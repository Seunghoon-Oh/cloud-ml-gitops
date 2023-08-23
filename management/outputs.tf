/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "kubernetes_endpoint" {
  description = "The management cluster endpoint"
  sensitive   = true
  value       = module.mgmt-gke-cluster.endpoint
}

output "client_token" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = base64encode(data.google_client_config.default.access_token)
}

output "ca_certificate" {
  description = "The management cluster ca certificate (base64 encoded)"
  sensitive   = true
  value       = module.mgmt-gke-cluster.ca_certificate
}

output "service_account" {
  description = "The default service account used for running nodes."
  value       = module.mgmt-gke-cluster.service_account
}

output "cluster_name" {
  description = "Management Cluster name"
  value       = module.mgmt-gke-cluster.name
}

output "k8s_service_account_name" {
  description = "Name of k8s service account."
  value       = module.workload_identity.k8s_service_account_name
}

output "gcp_service_account_email" {
  description = "Email address of GCP service account."
  value       = module.workload_identity.gcp_service_account_email
}

output "jenkins_k8s_config_secrets" {
  description = "Name of the secret required to configure k8s executers on Jenkins"
  value       = var.jenkins_k8s_config
}

output "project_id" {
  description = "Project id of Management GKE project"
  value       = var.project_id
}

output "zone" {
  description = "Zone of Management GKE cluster"
  value       = join(",", var.zones)
}
