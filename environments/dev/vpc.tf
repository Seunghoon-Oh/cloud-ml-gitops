# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-vpc-${var.class_id}-${var.member_id}"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-subnet-${var.class_id}-${var.member_id}"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet_cidr
}
