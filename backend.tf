terraform {
  backend "gcs" {
    bucket = "678d7968b717b2a4-bucket-tfstate"
    prefix = "terraform/state"
  }
}