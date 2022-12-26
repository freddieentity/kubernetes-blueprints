# module "eks" {

# }

module "kubernetes_addons" {
  source = "../../modules/kubernetes-addons"

  enable_networking_nginx_ingress_controller = true
  enable_networking_cert_manager = true

  enable_cicd_argocd = false

  enable_observability_kube_prometheus_stack = true
  enable_observability_elasticsearch = true
  enable_observability_kibana = true
  enable_observability_fluentd = true

  enable_security_vault = false
}
