terraform {
  backend "gcs" {
    bucket  = "gcp-clearify-terraform"
    prefix  = "tf-demo/state-prod/networking"
    project = "gcp-foundation-shared-devops"
  }
}
