terraform {
  backend "gcs" {
    bucket  = "cf-tf-seed-bucket"
    prefix  = "tf-demo/state/networking"
    project = "gcp-challenge-dev"
  }
}
