data "local_file" "helm_chart_values" {
  filename = "${path.module}/helm/jenkins-values.yaml"
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = "4.3.1"
  timeout    = 1200

  values = [data.local_file.helm_chart_values.content]

  depends_on = [
    kubernetes_secret.jenkins-secrets,
  ]
}

data "local_file" "argocd_helm_chart_values" {
  filename = "${path.module}/helm/argocd-values.yaml"
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.20.3"
  timeout    = 1200
  values     = [data.local_file.argocd_helm_chart_values.content]
}