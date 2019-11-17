resource "google_compute_router" "router" {
  name = "${var.cluster-name}nat-router"
  region = var.region
  network = "default"
  bgp {
    asn = 64512
  }
}

resource "google_compute_address" "address" {
  name = "${var.cluster-name}nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name = "${var.cluster-name}nat-gateway"
  router = google_compute_router.router.name
  region = var.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    google_compute_address.address.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}