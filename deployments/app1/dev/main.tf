resource "google_storage_bucket" "image-store-1" {
  name     = "cf-random-test-image-store-bucket-1"
  location = "asia-southeast1"
}