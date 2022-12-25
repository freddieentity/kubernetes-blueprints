# module "platform" {
#   source = "../../infrastructure/platform"
# }

module "networking" {
  source = "../../infrastructure/networking"

  enable_networking_nginx_ingress_controller = true
  enable_networking_cert_manager = true
}

# module "security" {
#   source = "../../infrastructure/security"
# }

module "cicd" {
  source = "../../infrastructure/cicd"

  enable_cicd_argocd = true
}

module "observability" {
  source = "../../infrastructure/observability"

  enable_observability_kube_prometheus_stack = true
}
