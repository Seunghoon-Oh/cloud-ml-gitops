variable "project_id" {
  description = "CI/CD를 구성할 GCP 프로젝트 ID"
}
variable "member_id" {
  description = "개인마다 부여된 클라우드/MSA 아키텍처 설계 Member ID"
}
variable "class_id" {
  description = "A과정 차수 ID"
  default = "2301"
}

variable "region" {
  description = "대상 리전"
  default     = "asia-northeast3"
}

variable "zones" {
  description = "GKE가 배포되는 zone 목록"
  default     = ["asia-northeast3-b"]
}

variable "network_name" {
  description = "VPC 네트워크의 이름"
  default     = "management-network"
}

variable "subnet_name" {
  description = "서브넷 이름"
  default     = "management-subnet"
}

variable "subnet_ip" {
  description = "서브넷 IP 범위"
  default     = "10.10.10.0/24"
}

variable "ip_range_pods_name" {
  description = "pod가 사용할 ip range"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "services가 사용할 ip range"
  default     = "ip-range-svc"
}

variable "jenkins_k8s_config" {
  description = "Name for the k8s secret required to configure k8s executers on Jenkins"
  default     = "jenkins-k8s-config"
}
