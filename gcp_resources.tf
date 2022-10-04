resource "google_compute_backend_bucket" "crc_resume" {
  bucket_name = "crc-resume"
  cdn_policy {
    cache_mode         = "CACHE_ALL_STATIC"
    client_ttl         = 3600
    default_ttl        = 3600
    max_ttl            = 86400
    request_coalescing = true
  }
  enable_cdn = true
  name       = "crc-resume"
  project    = "chris-personal-356410"
}
# terraform import google_compute_backend_bucket.crc_resume projects/chris-personal-356410/global/backendBuckets/crc-resume
resource "google_project" "chris_personal_356410" {
  auto_create_network = true
  billing_account     = "01C5C8-B4F3FA-DE964B"
  name                = "chris-personal"
  project_id          = "chris-personal-356410"
}
# terraform import google_project.chris_personal_356410 projects/chris-personal-356410
resource "google_compute_firewall" "default_allow_http" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "default-allow-http"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
# terraform import google_compute_firewall.default_allow_http projects/chris-personal-356410/global/firewalls/default-allow-http
resource "google_compute_firewall" "default_allow_https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "default-allow-https"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
# terraform import google_compute_firewall.default_allow_https projects/chris-personal-356410/global/firewalls/default-allow-https
resource "google_compute_firewall" "default_allow_internal" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  description   = "Allow internal traffic on the default network"
  direction     = "INGRESS"
  name          = "default-allow-internal"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 65534
  project       = "chris-personal-356410"
  source_ranges = ["10.128.0.0/9"]
}
# terraform import google_compute_firewall.default_allow_internal projects/chris-personal-356410/global/firewalls/default-allow-internal
resource "google_compute_firewall" "default_allow_icmp" {
  allow {
    protocol = "icmp"
  }
  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 65534
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_icmp projects/chris-personal-356410/global/firewalls/default-allow-icmp
resource "google_compute_firewall" "default_allow_rdp" {
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }
  description   = "Allow RDP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-rdp"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 65534
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_rdp projects/chris-personal-356410/global/firewalls/default-allow-rdp
resource "google_compute_firewall" "default_allow_ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  description   = "Allow SSH from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-ssh"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 65534
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_ssh projects/chris-personal-356410/global/firewalls/default-allow-ssh
resource "google_compute_firewall" "resume_blog_tcp_443" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "resume-blog-tcp-443"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["resume-blog-deployment"]
}
# terraform import google_compute_firewall.resume_blog_tcp_443 projects/chris-personal-356410/global/firewalls/resume-blog-tcp-443
resource "google_compute_firewall" "resume_blog_tcp_22" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "resume-blog-tcp-22"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["resume-blog-deployment"]
}
# terraform import google_compute_firewall.resume_blog_tcp_22 projects/chris-personal-356410/global/firewalls/resume-blog-tcp-22
resource "google_compute_firewall" "resume_blog_tcp_80" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "resume-blog-tcp-80"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["resume-blog-deployment"]
}
# terraform import google_compute_firewall.resume_blog_tcp_80 projects/chris-personal-356410/global/firewalls/resume-blog-tcp-80
resource "google_compute_firewall" "resume_blog_tcp_7080" {
  allow {
    ports    = ["7080"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  name          = "resume-blog-tcp-7080"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["resume-blog-deployment"]
}
# terraform import google_compute_firewall.resume_blog_tcp_7080 projects/chris-personal-356410/global/firewalls/resume-blog-tcp-7080
resource "google_compute_global_address" "resume_ip" {
  address      = "34.120.211.145"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  name         = "resume-ip"
  project      = "chris-personal-356410"
}
# terraform import google_compute_global_address.resume_ip projects/chris-personal-356410/global/addresses/resume-ip
resource "google_compute_global_forwarding_rule" "crc_lb_forwarding_rule" {
  ip_address            = "34.120.211.145"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crc-lb-forwarding-rule"
  port_range            = "80-80"
  project               = "chris-personal-356410"
  target                = "https://www.googleapis.com/compute/beta/projects/chris-personal-356410/global/targetHttpProxies/crc-lb-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.crc_lb_forwarding_rule projects/chris-personal-356410/global/forwardingRules/crc-lb-forwarding-rule
resource "google_compute_global_forwarding_rule" "crc_lb" {
  ip_address            = "34.120.211.145"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crc-lb"
  port_range            = "443-443"
  project               = "chris-personal-356410"
  target                = "https://www.googleapis.com/compute/beta/projects/chris-personal-356410/global/targetHttpsProxies/crc-lb-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.crc_lb projects/chris-personal-356410/global/forwardingRules/crc-lb
resource "google_compute_firewall" "resume_blog_udp_443" {
  allow {
    ports    = ["443"]
    protocol = "udp"
  }
  direction     = "INGRESS"
  name          = "resume-blog-udp-443"
  network       = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/networks/default"
  priority      = 1000
  project       = "chris-personal-356410"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["resume-blog-deployment"]
}
# terraform import google_compute_firewall.resume_blog_udp_443 projects/chris-personal-356410/global/firewalls/resume-blog-udp-443
resource "google_compute_image" "blog_image" {
  disk_size_gb = 10
  guest_os_features {
    type = "GVNIC"
  }
  guest_os_features {
    type = "SEV_CAPABLE"
  }
  guest_os_features {
    type = "UEFI_COMPATIBLE"
  }
  guest_os_features {
    type = "VIRTIO_SCSI_MULTIQUEUE"
  }
  licenses        = ["https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/licenses/ubuntu-2004-lts", "https://www.googleapis.com/compute/v1/projects/gc-image-pub/global/licenses/openlitespeed-wordpress"]
  name            = "blog-image"
  project         = "chris-personal-356410"
  source_snapshot = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/snapshots/blog-snapshot"
}

# terraform import google_compute_snapshot.blog_snapshot projects/chris-personal-356410/global/snapshots/blog-snapshot
resource "google_compute_ssl_certificate" "crc_resume_ssl" {
  certificate = "-----BEGIN CERTIFICATE-----\nMIIFZzCCBE+gAwIBAgIRANrvEv7hnQ8NCf4uBbuuSaEwDQYJKoZIhvcNAQELBQAw\nRjELMAkGA1UEBhMCVVMxIjAgBgNVBAoTGUdvb2dsZSBUcnVzdCBTZXJ2aWNlcyBM\nTEMxEzARBgNVBAMTCkdUUyBDQSAxRDQwHhcNMjIwOTA4MDkxNTMzWhcNMjIxMjA3\nMDkxNTMyWjAcMRowGAYDVQQDExFjaHJpc2pvaG5zb24udGVjaDCCASIwDQYJKoZI\nhvcNAQEBBQADggEPADCCAQoCggEBAMOlxjItwbv++kekMHJQcCxqOYkzuJ8K5LkV\nvoZMe1w4ORHyv+ODbjQX5QzOlUi8PDT1df1JvtcKtxw3ALp8SF/KczF4zDKJf+6F\ndDJQR3CsM9c9PDAKFtFKKq5r+1vZ5rSlKwfhweEaH8I30fe2PEUkzxP7eeiqg1FP\n7cdIT3WZTeLV3Mosf0DDQDpGK5BmoN84IiO1oxmcNLzVER4Sx796Fpjy7NjUtKvn\nfQsnGlrb4glEJQPRCqDyr0F++krIB6rVkTK/dcuwkcF9IHus6BudmGmh5fBvphvY\nj/Jvr7lCTiwnRVEnXFqlDyUA3CVmDkZmfNkkeOY3RY8isohrcoMCAwEAAaOCAngw\nggJ0MA4GA1UdDwEB/wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDATAMBgNVHRMB\nAf8EAjAAMB0GA1UdDgQWBBQ3qgh/MNZ3DRIYSErLpD6MAqXnnTAfBgNVHSMEGDAW\ngBQl4hgOsleRlCrl1F2GkIPeU7O4kjB4BggrBgEFBQcBAQRsMGowNQYIKwYBBQUH\nMAGGKWh0dHA6Ly9vY3NwLnBraS5nb29nL3MvZ3RzMWQ0L3JLZkYzSVNPLV9NMDEG\nCCsGAQUFBzAChiVodHRwOi8vcGtpLmdvb2cvcmVwby9jZXJ0cy9ndHMxZDQuZGVy\nMBwGA1UdEQQVMBOCEWNocmlzam9obnNvbi50ZWNoMCEGA1UdIAQaMBgwCAYGZ4EM\nAQIBMAwGCisGAQQB1nkCBQMwPAYDVR0fBDUwMzAxoC+gLYYraHR0cDovL2NybHMu\ncGtpLmdvb2cvZ3RzMWQ0L3dHUWl1R3RMMTdNLmNybDCCAQQGCisGAQQB1nkCBAIE\ngfUEgfIA8AB2AEalVet1+pEgMLWiiWn0830RLEF0vv1JuIWr8vxw/m1HAAABgxyf\nN9oAAAQDAEcwRQIgHqqse7+pt9oNHMaCo/pJpFgzoPTVhhwwhFXDpoPr6+ECIQDx\nsUxh1Yje8U3sxrtNf1l3vXDn6ZCRR1TpgUHem8vNhAB2AN+lXqtogk8fbK3uuF9O\nPlrqzaISpGpejjsSwCBEXCpzAAABgxyfN60AAAQDAEcwRQIhAJP1/p22ZBkArA5r\no0GtCu7TYpQUbl2PcBmfXonjpn8dAiBKD9EXt0khZZyxYXYtmMLPDKbVtpNhZi2j\nVxuGRMlQEDANBgkqhkiG9w0BAQsFAAOCAQEAnAX09qs0nQ5FeDl/pZmTPOxElepT\nXZCyx2IP0NeJGAE+rBrveloIhqKB7dhPU6hRFHr5YmsMgtc6o8kOu8dLdw059AIO\n5qQSdpj6GLzqPl310EegMC7WZ2ijnZSmT55OJmtV5e6cIabM+AJCoGWgVKUuFrob\nqGjPapMp9hqWrAaokknf/ILdJCwthBtNgoPnE2zkNjBfE7XEW7SZN9xXmSPM1oeT\n3ZsD14pZtbrTT/wBF51fYaD1v+4WVRFEKw6DXDhOi+M+mHacUKKMpgkw+fPDTvfL\nocPu3HNUF1RvZ0f2z+z52Z4b9Z1vtD7lpcSpZu3b9TbHsvJDZeSqZQ0AmQ==\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIFjDCCA3SgAwIBAgINAgCOsgIzNmWLZM3bmzANBgkqhkiG9w0BAQsFADBHMQsw\nCQYDVQQGEwJVUzEiMCAGA1UEChMZR29vZ2xlIFRydXN0IFNlcnZpY2VzIExMQzEU\nMBIGA1UEAxMLR1RTIFJvb3QgUjEwHhcNMjAwODEzMDAwMDQyWhcNMjcwOTMwMDAw\nMDQyWjBGMQswCQYDVQQGEwJVUzEiMCAGA1UEChMZR29vZ2xlIFRydXN0IFNlcnZp\nY2VzIExMQzETMBEGA1UEAxMKR1RTIENBIDFENDCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAKvAqqPCE27l0w9zC8dTPIE89bA+xTmDaG7y7VfQ4c+mOWhl\nUebUQpK0yv2r678RJExK0HWDjeq+nLIHN1Em5j6rARZixmyRSjhIR0KOQPGBMUld\nsaztIIJ7O0g/82qj/vGDl//3t4tTqxiRhLQnTLXJdeB+2DhkdU6IIgx6wN7E5NcU\nH3Rcsejcqj8p5Sj19vBm6i1FhqLGymhMFroWVUGO3xtIH91dsgy4eFKcfKVLWK3o\n2190Q0Lm/SiKmLbRJ5Au4y1euFJm2JM9eB84Fkqa3ivrXWUeVtye0CQdKvsY2Fka\nzvxtxvusLJzLWYHk55zcRAacDA2SeEtBbQfD1qsCAwEAAaOCAXYwggFyMA4GA1Ud\nDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwEgYDVR0T\nAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUJeIYDrJXkZQq5dRdhpCD3lOzuJIwHwYD\nVR0jBBgwFoAU5K8rJnEaK0gnhS9SZizv8IkTcT4waAYIKwYBBQUHAQEEXDBaMCYG\nCCsGAQUFBzABhhpodHRwOi8vb2NzcC5wa2kuZ29vZy9ndHNyMTAwBggrBgEFBQcw\nAoYkaHR0cDovL3BraS5nb29nL3JlcG8vY2VydHMvZ3RzcjEuZGVyMDQGA1UdHwQt\nMCswKaAnoCWGI2h0dHA6Ly9jcmwucGtpLmdvb2cvZ3RzcjEvZ3RzcjEuY3JsME0G\nA1UdIARGMEQwCAYGZ4EMAQIBMDgGCisGAQQB1nkCBQMwKjAoBggrBgEFBQcCARYc\naHR0cHM6Ly9wa2kuZ29vZy9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAgEA\nIVToy24jwXUr0rAPc924vuSVbKQuYw3nLflLfLh5AYWEeVl/Du18QAWUMdcJ6o/q\nFZbhXkBH0PNcw97thaf2BeoDYY9Ck/b+UGluhx06zd4EBf7H9P84nnrwpR+4GBDZ\nK+Xh3I0tqJy2rgOqNDflr5IMQ8ZTWA3yltakzSBKZ6XpF0PpqyCRvp/NCGv2KX2T\nuPCJvscp1/m2pVTtyBjYPRQ+QuCQGAJKjtN7R5DFrfTqMWvYgVlpCJBkwlu7+7KY\n3cTIfzE7cmALskMKNLuDz+RzCcsYTsVaU7Vp3xL60OYhqFkuAOOxDZ6pHOj9+OJm\nYgPmOT4X3+7L51fXJyRH9KfLRP6nT31D5nmsGAOgZ26/8T9hsBW1uo9ju5fZLZXV\nVS5H0HyIBMEKyGMIPhFWrlt/hFS28N1zaKI0ZBGD3gYgDLbiDT9fGXstpk+Fmc4o\nlVlWPzXe81vdoEnFbr5M272HdgJWo+WhT9BYM0Ji+wdVmnRffXgloEoluTNcWzc4\n1dFpgJu8fF3LG0gl2ibSYiCi9a6hvU0TppjJyIWXhkJTcMJlPrWx1VytEUGrX2l0\nJDwRjW/656r0KVB02xHRKvm2ZKI03TglLIpmVCK3kBKkKNpBNkFt8rhafcCKOb9J\nx/9tpNFlQTl7B39rJlJWkR17QnZqVptFePFORoZmFzM=\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIFYjCCBEqgAwIBAgIQd70NbNs2+RrqIQ/E8FjTDTANBgkqhkiG9w0BAQsFADBX\nMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UE\nCxMHUm9vdCBDQTEbMBkGA1UEAxMSR2xvYmFsU2lnbiBSb290IENBMB4XDTIwMDYx\nOTAwMDA0MloXDTI4MDEyODAwMDA0MlowRzELMAkGA1UEBhMCVVMxIjAgBgNVBAoT\nGUdvb2dsZSBUcnVzdCBTZXJ2aWNlcyBMTEMxFDASBgNVBAMTC0dUUyBSb290IFIx\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAthECix7joXebO9y/lD63\nladAPKH9gvl9MgaCcfb2jH/76Nu8ai6Xl6OMS/kr9rH5zoQdsfnFl97vufKj6bwS\niV6nqlKr+CMny6SxnGPb15l+8Ape62im9MZaRw1NEDPjTrETo8gYbEvs/AmQ351k\nKSUjB6G00j0uYODP0gmHu81I8E3CwnqIiru6z1kZ1q+PsAewnjHxgsHA3y6mbWwZ\nDrXYfiYaRQM9sHmklCitD38m5agI/pboPGiUU+6DOogrFZYJsuB6jC511pzrp1Zk\nj5ZPaK49l8KEj8C8QMALXL32h7M1bKwYUH+E4EzNktMg6TO8UpmvMrUpsyUqtEj5\ncuHKZPfmghCN6J3Cioj6OGaK/GP5Afl4/Xtcd/p2h/rs37EOeZVXtL0m79YB0esW\nCruOC7XFxYpVq9Os6pFLKcwZpDIlTirxZUTQAs6qzkm06p98g7BAe+dDq6dso499\niYH6TKX/1Y7DzkvgtdizjkXPdsDtQCv9Uw+wp9U7DbGKogPeMa3Md+pvez7W35Ei\nEua++tgy/BBjFFFy3l3WFpO9KWgz7zpm7AeKJt8T11dleCfeXkkUAKIAf5qoIbap\nsZWwpbkNFhHax2xIPEDgfg1azVY80ZcFuctL7TlLnMQ/0lUTbiSw1nH69MG6zO0b\n9f6BQdgAmD06yK56mDcYBZUCAwEAAaOCATgwggE0MA4GA1UdDwEB/wQEAwIBhjAP\nBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTkrysmcRorSCeFL1JmLO/wiRNxPjAf\nBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzBgBggrBgEFBQcBAQRUMFIw\nJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnBraS5nb29nL2dzcjEwKQYIKwYBBQUH\nMAKGHWh0dHA6Ly9wa2kuZ29vZy9nc3IxL2dzcjEuY3J0MDIGA1UdHwQrMCkwJ6Al\noCOGIWh0dHA6Ly9jcmwucGtpLmdvb2cvZ3NyMS9nc3IxLmNybDA7BgNVHSAENDAy\nMAgGBmeBDAECATAIBgZngQwBAgIwDQYLKwYBBAHWeQIFAwIwDQYLKwYBBAHWeQIF\nAwMwDQYJKoZIhvcNAQELBQADggEBADSkHrEoo9C0dhemMXoh6dFSPsjbdBZBiLg9\nNR3t5P+T4Vxfq7vqfM/b5A3Ri1fyJm9bvhdGaJQ3b2t6yMAYN/olUazsaL+yyEn9\nWprKASOshIArAoyZl+tJaox118fessmXn1hIVw41oeQa1v1vg4Fv74zPl6/AhSrw\n9U5pCZEt4Wi4wStz6dTZ/CLANx8LZh1J7QJVj2fhMtfTJr9w4z30Z209fOU0iOMy\n+qduBmpvvYuR7hZL6Dupszfnw0Skfths18dG9ZKb59UhvmaSGZRVbNQpsg3BZlvi\nd0lIKO2d1xozclOzgjXPYovJJIultzkMu34qQb9Sz/yilrbCgj8=\n-----END CERTIFICATE-----\n"
  name        = "crc-resume-ssl"
  project     = "chris-personal-356410"
}

# terraform import google_compute_ssl_certificate.crc_resume_ssl projects/chris-personal-356410/global/sslCertificates/crc-resume-ssl
resource "google_compute_target_http_proxy" "crc_lb_target_proxy" {
  name    = "crc-lb-target-proxy"
  project = "chris-personal-356410"
  url_map = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/urlMaps/crc-lb-redirect"
}

# terraform import google_compute_target_http_proxy.crc_lb_target_proxy projects/chris-personal-356410/global/targetHttpProxies/crc-lb-target-proxy
resource "google_compute_url_map" "crc_lb_redirect" {
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
  description = "Automatically generated HTTP to HTTPS redirect for the crc-lb forwarding rule"
  name        = "crc-lb-redirect"
  project     = "chris-personal-356410"
}
# terraform import google_compute_url_map.crc_lb_redirect projects/chris-personal-356410/global/urlMaps/crc-lb-redirect
resource "google_dns_managed_zone" "personal_site_zone" {
  dns_name      = "chrisjohnson.tech."
  force_destroy = false
  name          = "personal-site-zone"
  project       = "chris-personal-356410"
  visibility    = "public"
}
# terraform import google_dns_managed_zone.personal_site_zone projects/chris-personal-356410/managedZones/personal-site-zone
resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "358844651335"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 358844651335/cloudtrace.googleapis.com
resource "google_compute_target_https_proxy" "crc_lb_target_proxy" {
  name             = "crc-lb-target-proxy"
  project          = "chris-personal-356410"
  quic_override    = "NONE"
  ssl_certificates = ["https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/sslCertificates/crc-resume-ssl"]
  url_map          = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/urlMaps/crc-lb"
}
# terraform import google_compute_target_https_proxy.crc_lb_target_proxy projects/chris-personal-356410/global/targetHttpsProxies/crc-lb-target-proxy
resource "google_logging_log_sink" "a_required" {
  destination            = "logging.googleapis.com/projects/chris-personal-356410/locations/global/buckets/_Required"
  filter                 = "LOG_ID(\"cloudaudit.googleapis.com/activity\") OR LOG_ID(\"externalaudit.googleapis.com/activity\") OR LOG_ID(\"cloudaudit.googleapis.com/system_event\") OR LOG_ID(\"externalaudit.googleapis.com/system_event\") OR LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") OR LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Required"
  project                = "358844651335"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_required 358844651335###_Required
resource "google_project_service" "dns_googleapis_com" {
  project = "358844651335"
  service = "dns.googleapis.com"
}
# terraform import google_project_service.dns_googleapis_com 358844651335/dns.googleapis.com
resource "google_compute_url_map" "crc_lb" {
  default_service = "https://www.googleapis.com/compute/v1/projects/chris-personal-356410/global/backendBuckets/crc-resume"
  name            = "crc-lb"
  project         = "chris-personal-356410"
}
# terraform import google_compute_url_map.crc_lb projects/chris-personal-356410/global/urlMaps/crc-lb
resource "google_project_service" "firestore_googleapis_com" {
  project = "358844651335"
  service = "firestore.googleapis.com"
}
# terraform import google_project_service.firestore_googleapis_com 358844651335/firestore.googleapis.com
resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "358844651335"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 358844651335/bigquerystorage.googleapis.com
resource "google_logging_log_sink" "a_default" {
  destination            = "logging.googleapis.com/projects/chris-personal-356410/locations/global/buckets/_Default"
  filter                 = "NOT LOG_ID(\"cloudaudit.googleapis.com/activity\") AND NOT LOG_ID(\"externalaudit.googleapis.com/activity\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"externalaudit.googleapis.com/system_event\") AND NOT LOG_ID(\"cloudaudit.googleapis.com/access_transparency\") AND NOT LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
  name                   = "_Default"
  project                = "358844651335"
  unique_writer_identity = true
}
# terraform import google_logging_log_sink.a_default 358844651335###_Default
resource "google_project_service" "storage_googleapis_com" {
  project = "358844651335"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 358844651335/storage.googleapis.com
resource "google_project_service" "compute_googleapis_com" {
  project = "358844651335"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 358844651335/compute.googleapis.com
resource "google_project_service" "monitoring_googleapis_com" {
  project = "358844651335"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 358844651335/monitoring.googleapis.com
resource "google_project_service" "clouddebugger_googleapis_com" {
  project = "358844651335"
  service = "clouddebugger.googleapis.com"
}
# terraform import google_project_service.clouddebugger_googleapis_com 358844651335/clouddebugger.googleapis.com
resource "google_project_service" "iam_googleapis_com" {
  project = "358844651335"
  service = "iam.googleapis.com"
}
# terraform import google_service_account.358844651335_compute projects/chris-personal-356410/serviceAccounts/358844651335-compute@chris-personal-356410.iam.gserviceaccount.com
resource "google_project_service" "logging_googleapis_com" {
  project = "358844651335"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 358844651335/logging.googleapis.com
resource "google_project_service" "serviceusage_googleapis_com" {
  project = "358844651335"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 358844651335/serviceusage.googleapis.com
resource "google_project_service" "cloudresourcemanager_googleapis_com" {
  project = "358844651335"
  service = "cloudresourcemanager.googleapis.com"
}
# terraform import google_project_service.cloudresourcemanager_googleapis_com 358844651335/cloudresourcemanager.googleapis.com
resource "google_project_service" "runtimeconfig_googleapis_com" {
  project = "358844651335"
  service = "runtimeconfig.googleapis.com"
}
# terraform import google_project_service.runtimeconfig_googleapis_com 358844651335/runtimeconfig.googleapis.com
resource "google_project_service" "cloudapis_googleapis_com" {
  project = "358844651335"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 358844651335/cloudapis.googleapis.com
resource "google_project_service" "bigquery_googleapis_com" {
  project = "358844651335"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 358844651335/bigquery.googleapis.com
resource "google_storage_bucket" "crc_resume" {
  force_destroy            = false
  location                 = "US"
  name                     = "crc-resume"
  project                  = "chris-personal-356410"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
# terraform import google_storage_bucket.crc_resume crc-resume
resource "google_project_service" "oslogin_googleapis_com" {
  project = "358844651335"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 358844651335/oslogin.googleapis.com
resource "google_project_service" "datastore_googleapis_com" {
  project = "358844651335"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 358844651335/datastore.googleapis.com
resource "google_project_service" "deploymentmanager_googleapis_com" {
  project = "358844651335"
  service = "deploymentmanager.googleapis.com"
}
# terraform import google_project_service.deploymentmanager_googleapis_com 358844651335/deploymentmanager.googleapis.com
resource "google_project_service" "iamcredentials_googleapis_com" {
  project = "358844651335"
  service = "iamcredentials.googleapis.com"
}
# terraform import google_project_service.iamcredentials_googleapis_com 358844651335/iamcredentials.googleapis.com
resource "google_project_service" "bigquerymigration_googleapis_com" {
  project = "358844651335"
  service = "bigquerymigration.googleapis.com"
}
# terraform import google_project_service.bigquerymigration_googleapis_com 358844651335/bigquerymigration.googleapis.com
resource "google_project_service" "storage_api_googleapis_com" {
  project = "358844651335"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 358844651335/storage-api.googleapis.com
resource "google_project_service" "sts_googleapis_com" {
  project = "358844651335"
  service = "sts.googleapis.com"
}
# terraform import google_project_service.sts_googleapis_com 358844651335/sts.googleapis.com
resource "google_project_service" "sql_component_googleapis_com" {
  project = "358844651335"
  service = "sql-component.googleapis.com"
}
# terraform import google_project_service.sql_component_googleapis_com 358844651335/sql-component.googleapis.com
resource "google_project_service" "storage_component_googleapis_com" {
  project = "358844651335"
  service = "storage-component.googleapis.com"
}
# terraform import google_project_service.storage_component_googleapis_com 358844651335/storage-component.googleapis.com
resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "358844651335"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 358844651335/servicemanagement.googleapis.com
resource "google_project_service" "cloudasset_googleapis_com" {
  project = "358844651335"
  service = "cloudasset.googleapis.com"
}
# terraform import google_project_service.cloudasset_googleapis_com 358844651335/cloudasset.googleapis.com
resource "google_iam_custom_role" "github_actions_runner" {
  description = "Created on: 2022-09-26"
  permissions = ["resourcemanager.projects.get", "storage.buckets.get", "storage.buckets.list", "storage.objects.create", "storage.objects.delete", "storage.objects.get", "storage.objects.list", "storage.objects.update"]
  project     = "chris-personal-356410"
  role_id     = "github_actions_runner"
  stage       = "GA"
  title       = "Custom - GitHub Actions Runner"
}
# terraform import google_iam_custom_role.github_actions_runner chris-personal-356410##github_actions_runner
resource "google_service_account" "crc_github_runner" {
  account_id   = "crc-github-runner"
  display_name = "CRC GitHub Runner"
  project      = "chris-personal-356410"
}
# terraform import google_service_account.crc_github_runner projects/chris-personal-356410/serviceAccounts/crc-github-runner@chris-personal-356410.iam.gserviceaccount.com
resource "google_project_service" "firebaserules_googleapis_com" {
  project = "358844651335"
  service = "firebaserules.googleapis.com"
}
# terraform import google_project_service.firebaserules_googleapis_com 358844651335/firebaserules.googleapis.com
