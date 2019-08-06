terraform {
  backend "gcs" {
    bucket  = "cf-tf-seed-bucket"
    prefix  = "tf-demo/state-prod/networking"
    project = "gcp-challenge-dev"
  }
}
