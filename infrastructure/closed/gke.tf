resource "google_container_cluster" "primary" {
  name = "${var.cluster-name}cluster"
  location = var.location

  remove_default_node_pool = true
  initial_node_count = 1

  subnetwork = "default"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.96.0.0/11"
    services_ipv4_cidr_block = "10.94.0.0/18"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "any"
    }
  }
  master_auth {
    username = ""
    password = ""
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name = "${var.cluster-name}node-pool"
  location = var.location
  cluster = google_container_cluster.primary.name
  node_count = 3

  management {
    auto_repair = true
  }

  node_config {
    preemptible = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}