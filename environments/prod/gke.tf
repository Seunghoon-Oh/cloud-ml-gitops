# GKE cluster
resource "google_container_cluster" "primary" {
  provider       = google-beta
  name           = "${var.environment}-gke-${var.class_id}-${var.member_id}"
  location       = var.region
  node_locations = var.zones
  
  remove_default_node_pool = true
  initial_node_count       = 1
  
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
 
  addons_config {
    istio_config {
      disabled = false
      auth     = "AUTH_MUTUAL_TLS"
    }
  }
}
  
# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-np"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  
    labels = {
      env = var.project_id
    }
  
    # preemptible  = true
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.environment}-${var.class_id}-${var.member_id}"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Separately Managed Cloud ML Notebook Node Pool
resource "google_container_node_pool" "notebook_nodes" {
  name       = "${google_container_cluster.primary.name}-notebook-np"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.notebook_gke_num_nodes
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  
    labels = {
      env = var.project_id, 
      cloud-ml-product = "notebook"
    }
  
    # preemptible  = true
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.environment}-${var.class_id}-${var.member_id}"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
  
  
resource "kubernetes_namespace" "cloud-ml" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "cloud-ml"
  }
}

resource "kubernetes_namespace" "cloud-ml-mgmt" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "cloud-ml-mgmt"
  }
}

resource "kubernetes_namespace" "cloud-ml-studio" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "cloud-ml-studio"
  }
}

resource "kubernetes_namespace" "cloud-ml-notebook" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "cloud-ml-notebook"
  }
}

resource "kubernetes_namespace" "cloud-ml-pipeline" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "cloud-ml-pipeline"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations    = {}
    labels         = {
      istio-injection = "enabled"
    }
    name = "monitoring"
  }
}