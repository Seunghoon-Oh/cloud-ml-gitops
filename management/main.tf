/*****************************************
  Google Provider Configuration
 *****************************************/
provider "google" {
}

/*****************************************
  Kubernetes provider configuration
 *****************************************/
provider "kubernetes" {
  host                   = "https://${module.mgmt-gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.mgmt-gke-cluster.ca_certificate)
}

/*****************************************
  Helm provider configuration
 *****************************************/

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(module.mgmt-gke-cluster.ca_certificate)
    host                   = "https://${module.mgmt-gke-cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
  }
}