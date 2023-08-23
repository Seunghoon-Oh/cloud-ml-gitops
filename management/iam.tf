/*****************************************
  IAM Bindings GKE SVC
 *****************************************/
# allow GKE to pull images from GCR
resource "google_project_iam_member" "gke" {
  project = var.project_id
  role    = "roles/storage.objectViewer"

  member = "serviceAccount:${module.mgmt-gke-cluster.service_account}"
}

/*****************************************
  Management Workload Identity
  Docs - https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
 *****************************************/
module "workload_identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "~> 25.0.0"
  project_id          = var.project_id
  name                = "wi-${module.mgmt-gke-cluster.name}"
  namespace           = "default"
  use_existing_k8s_sa = false
  roles               = ["roles/storage.admin", "roles/container.developer", "roles/editor"]
}
