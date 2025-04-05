resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["ssh-access"]
}

resource "google_compute_firewall" "allow_kafka" {
  name    = "allow-kafka"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["9092"]
  }

  source_ranges = ["172.20.0.0/16"]

  target_tags = ["kafka-access"]
}
