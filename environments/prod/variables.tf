variable "environment" {
  type        = string
  description = "Name of the environment (dev or prod)"
  default     = "dev"
}

variable "project_id" {
  description = "GCP project id"
}
variable "class_id" {
  description = "Cloud/MSA 과정 차수 ID"
  default     = "2301"
}
variable "member_id" {
  description = "member id"
}

variable "region" {
  description = "region"
  default     = "asia-northeast3"
}

variable "zones" {
  description = "zones"
  default     = ["asia-northeast3-b"]
}

variable "subnet_cidr" {
  type        = string
  description = "VPC Network CIDR to be assigned to the VPC being created"
  default     = "10.0.0.0/16"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "product_gke_num_nodes" {
  default     = 1
  description = "number of gke product nodes"
}

variable "machine_type" {
  default     = "n1-standard-1"
  description = "Node pool machine type"
}

data "google_client_config" "default" {
}