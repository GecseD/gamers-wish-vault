resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("${path.module}/yaml/namespace.yaml"))
}

locals {
  env = { 
    for line in split("\n", file("${path.module}/../../../.env")) :
    split("=", line)[0] => split("=", line)[1]
    if length(trim(line, " \t\n\r")) > 0 && !startswith(trim(line, " \t\n\r"), "#")
  }
}


resource "kubernetes_manifest" "backend_secret" {
  manifest = {
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      name      = "backend-secrets"
      namespace = "app"
    }
    type = "Opaque"
    data = {
      MONGO_DB_USERNAME         = base64encode(local.env["MONGO_DB_USERNAME"])
      MONGO_DB_CLUSTER_PASSWORD = base64encode(local.env["MONGO_DB_CLUSTER_PASSWORD"])
      API_KEY                   = base64encode(local.env["API_KEY"])
    }
  }
  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "backend_deployment" {
  manifest = yamldecode(file("${path.module}/yaml/backend_deployment.yaml"))
  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.backend_secret
  ]
}

resource "kubernetes_manifest" "backend_service" {
  manifest = yamldecode(file("${path.module}/yaml/backend_service.yaml"))
  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "frontend_deployment" {
  manifest = yamldecode(file("${path.module}/yaml/frontend_deployment.yaml"))
  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "frontend_service" {
  manifest = yamldecode(file("${path.module}/yaml/frontend_service.yaml"))
  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "app_ingress" {
  manifest   = yamldecode(file("${path.module}/yaml/ingress.yaml"))
  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.backend_service,
    kubernetes_manifest.frontend_service
  ]
}
