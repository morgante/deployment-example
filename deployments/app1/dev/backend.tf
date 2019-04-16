terraform {
  backend "gcs" {
    bucket  = "gcp-clearify-terraform"
    prefix  = "tf-demo/state-dev/app1"
  }
}
