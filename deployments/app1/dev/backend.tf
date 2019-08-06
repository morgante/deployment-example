terraform {
  backend "gcs" {
    bucket  = "cf-tf-seed-bucket"
    prefix  = "tf-demo/state-dev/app1"
    project = "gcp-challenge-dev"
  }
}
