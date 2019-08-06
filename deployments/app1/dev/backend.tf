terraform {
  backend "gcs" {
    bucket  = "cf-tf-seed-bucket"
    prefix  = "tf-demo/state-dev/app1"
  }
}
