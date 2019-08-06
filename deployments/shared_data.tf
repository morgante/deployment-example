data "terraform_remote_state" "networking-dev" {
  backend = "gcs"

  config {
    bucket  = "cf-tf-seed-bucket"
    prefix  = "tf-demo/state/networking"
  }
}
