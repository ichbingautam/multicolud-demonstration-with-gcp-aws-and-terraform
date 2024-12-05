resource "google_compute_network" "multicloud-vpc" {
  name = "multicloud-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "multicloud-subnet" {
 name          = "${var.name}-subnet"
 ip_cidr_range = "10.0.0.0/24"
 network       = google_compute_network.multicloud-vpc.id
#  depends_on    = ["google_compute_network.multicloud-vpc"]
 region      = "${var.region}"
}

resource "google_compute_firewall" "multicloud-vpc-firewall" {
  name    = "multicloud-firewall"
  network = google_compute_network.multicloud-vpc.id

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_tags = ["web"]
}

