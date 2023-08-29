/*****************************************
  Management GKE Cluster
 *****************************************/
module "mgmt-gke-cluster" {
  source                   = "terraform-google-modules/kubernetes-engine/google"
  version                  = "~> 25.0.0"
  project_id               = var.project_id
  name                     = "mgmt-gke-${var.class_id}-${var.member_id}"
  regional                 = false
  region                   = var.region
  zones                    = var.zones
  network                  = module.mgmt-vpc.network_name
  subnetwork               = module.mgmt-vpc.subnets_names[0]
  ip_range_pods            = var.ip_range_pods_name
  ip_range_services        = var.ip_range_services_name
  http_load_balancing      = false
  network_policy           = false
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  remove_default_node_pool = true
  service_account          = "create"
  identity_namespace       = "${var.project_id}.svc.id.goog"
  node_metadata            = "GKE_METADATA_SERVER"
  node_pools = [
    {
      name         = "butler-pool"
      min_count    = 1
      max_count    = 3
      auto_upgrade = true
      machine_type = "e2-standard-4"
    }
  ]
}

/*****************************************
  K8S secrets for configuring K8S executers
 *****************************************/
resource "kubernetes_secret" "jenkins-secrets" {
  metadata {
    name = var.jenkins_k8s_config
  }
  data = {
    project_id          = var.project_id
    kubernetes_endpoint = "https://${module.mgmt-gke-cluster.endpoint}"
    ca_certificate      = module.mgmt-gke-cluster.ca_certificate
    jenkins_tf_ksa      = module.workload_identity.k8s_service_account_name
  }
}