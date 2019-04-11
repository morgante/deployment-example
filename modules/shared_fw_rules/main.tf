resource "google_compute_firewall" "allow-https" {
  name    = "${var.network}-allow-https"
  network = "${var.network}"
  project = "${var.host_project}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["allow-https"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http" {
  name    = "${var.network}-allow-http"
  network = "${var.network}"
  project = "${var.host_project}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["allow-https"]
  source_ranges = ["0.0.0.0/0"]
}
