terraform {
  backend "gcs" {
    bucket  = "gcp-clearify-terraform"
    prefix  = "tf-demo/state/networking"
    project = "gcp-foundation-shared-devops"
  }
}
