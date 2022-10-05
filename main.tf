#Setup GCP Provider
provider "google" {
  project     = "crc-prod-site"
  region      = "eu-west2"
}

#Enable required APIs
resource "google_project_service" "cloud_asset_api" {
    project = "crc-prod-site"
    service = "cloudasset.googleapis.com"
}

resource "google_project_service" "iam_creds_api" {
    project = "crc-prod-site"
    service = "iamcredentials.googleapis.com"
}

resource "google_project_service" "sec_token_api" {
    project = "crc-prod-site"
    service = "sts.googleapis.com"
}

resource "google_project_service" "dns_api" {
    project = "crc-prod-site"
    service = "dns.googleapis.com"
}

#Allow internet traffic
resource "google_compute_firewall" "http" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "default-allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

/*
Run first time in new project
Left enabled as delay in re-enabling causing issues
resource "google_project_service" "compute_api" {
    project = "crc-prod-site"
    service = "compute.googleapis.com"
}
*/

#Workload Identity Federation
/*
Run first time in new project
Commenting out as 'terraform destroy' soft deletes but 'terraform apply' will not undelete

resource "google_iam_workload_identity_pool" "identity_pool" {
    workload_identity_pool_id = "prod-pool"
    display_name              = "Production WI Pool"          
}

resource "google_iam_workload_identity_pool_provider" "github_wi_provider" {
    workload_identity_pool_id           = google_iam_workload_identity_pool.identity_pool.workload_identity_pool_id
    workload_identity_pool_provider_id  = "github-provider"
    display_name                        = "GitHub Actions"
    attribute_mapping = {
        "google.subject"    = "assertion.sub"
        "attribute.actor"   = "assertion.actor"
        "attribute.aud"     = "assertion.aud"
    }
    oidc {
        issuer_uri          = "https://token.actions.githubusercontent.com"  
    }
}
*/

#Create service accounts and assign roles
resource "google_service_account" "gh_actions_account" {
    account_id  = "github-actions-runner"
    display_name = "GitHub Actions Runner"
}

resource "google_project_iam_member" "cloud_asset_owner" {
  project = "crc-prod-site"
  role    = "roles/cloudasset.owner"
  member  = "serviceAccount:github-actions-runner@crc-prod-site.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "storage_admin" {
  project = "crc-prod-site"
  role    = "roles/storage.admin"
  member  = "serviceAccount:github-actions-runner@crc-prod-site.iam.gserviceaccount.com"
}

resource "google_service_account_iam_binding" "service-account-iam" {
  service_account_id = "projects/crc-prod-site/serviceAccounts/github-actions-runner@crc-prod-site.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/projects/613299291948/locations/global/workloadIdentityPools/prod-pool/attribute.repository/CJ1138/crc"
  ]
  depends_on = [
    google_service_account.gh_actions_account
  ]
}

#Create storage bucket and make public
resource "google_storage_bucket" "crc-resume-bucket" {
    name            = "crc-prod-bucket"
    location        = "EU"
    force_destroy   = true

    website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

}

resource "google_storage_bucket_iam_member" "public-rule" {
  bucket = google_storage_bucket.crc-resume-bucket.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}

#Create Load Balancer
resource "google_compute_managed_ssl_certificate" "resume-ssl" {
  name = "resume-ssl"
  managed {
    domains = ["chrisjohnson.tech"]
  }
}

resource "google_compute_global_address" "lb-ip" {
  name       = "lb-ipv4"
  ip_version = "IPV4"
}

resource "google_compute_backend_bucket" "resume-bucket" {
  name        = "resume-bucket"
  description = "Bucket for static site content"
  bucket_name = google_storage_bucket.crc-resume-bucket.name
  enable_cdn  = true
}

resource "google_compute_url_map" "https-url-map" {
  name        = "https-url-map"
  description = "Load Balancer https URL map"
  default_service = google_compute_backend_bucket.resume-bucket.id
}

resource "google_compute_target_https_proxy" "https-proxy" {
  name             = "https-proxy"
  url_map          = google_compute_url_map.https-url-map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.resume-ssl.id]
}

resource "google_compute_url_map" "http-redirect" {
  name = "http-redirect"

  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
    https_redirect         = true
  }
}

resource "google_compute_target_http_proxy" "http-redirect" {
  name    = "http-redirect"
  url_map = google_compute_url_map.http-redirect.self_link
}

resource "google_compute_global_forwarding_rule" "http-redirect" {
  name       = "http-redirect"
  target     = google_compute_target_http_proxy.http-redirect.self_link
  ip_address = google_compute_global_address.lb-ip.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  name                  = "ssl-proxy-forwarding-rule"
  provider              = google
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.https-proxy.id
  ip_address            = google_compute_global_address.lb-ip.address
}

#DNS Zone and settings

resource "google_dns_managed_zone" "personal-dns-zone" {
  name        = "personal-dns-zone"
  dns_name    = "chrisjohnson.tech."
  description = "DNS Zone for tech blog & resume"
}

resource "google_dns_record_set" "resume-dns" {
  managed_zone = google_dns_managed_zone.personal-dns-zone.name
  name         = "chrisjohnson.tech."
  type         = "A"
  rrdatas      = [google_compute_global_address.lb-ip.address]
  ttl          = 300
}

resource "google_dns_record_set" "blog-dns" {
  managed_zone = google_dns_managed_zone.personal-dns-zone.name
  name         = "blog.chrisjohnson.tech."
  type         = "A"
  rrdatas      = ["35.234.151.199"]
  ttl          = 300
}

resource "google_dns_record_set" "resume-www-dns" {
  managed_zone = google_dns_managed_zone.personal-dns-zone.name
  name         = "www.chrisjohnson.tech."
  type         = "CNAME"
  rrdatas      = ["chrisjohnson.tech."]
  ttl          = 300
}

#Reference outputs
output "static_ip" {
    value = google_compute_global_address.lb-ip.address
}

output "ssl_cert" {
    value = google_compute_managed_ssl_certificate.resume-ssl.id
}

output "bucket_url" {
    value = google_storage_bucket.crc-resume-bucket.url
}