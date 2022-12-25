module "nginx_ingress_controller" {
  source = "../../resources/networking/nginx-ingress-controller"

  count = var.enable_networking_nginx_ingress_controller ? 1 : 0
}

module "cert_manager" {
  source = "../../resources/networking/cert-manager"

  count = var.enable_networking_cert_manager ? 1 : 0
}