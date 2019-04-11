
data "terraform_remote_state" "networking-dev" {
  backend = "gcs"

  config {
    bucket  = "gcp-clearify-terraform"
    prefix  = "tf-demo/state/networking"
    project = "gcp-foundation-shared-devops"
  }
}
