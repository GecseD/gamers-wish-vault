module "k8s_ingress_controller" {
  source = "./k8s-ingress-controller"
}

module "k8s_app" {
  source = "./k8s-app"
  depends_on = [module.k8s_ingress_controller]
}