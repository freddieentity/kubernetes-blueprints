# module "eks" {
#   source = "./modules/aws-eks-managed-node-groups"
# }

module "kubernetes_addons" {
  source = "./modules/kubernetes-addons"

  # CICD
  cicd_argocd = local.cicd_argocd
  cicd_argocd_apps = local.cicd_argocd_apps
  cicd_argo_rollouts = local.cicd_argo_rollouts

  # NETWORKING
  networking_nginx_ingress_controller = local.networking_nginx_ingress_controller
  networking_ambassador_ingress_controller = local.networking_ambassador_ingress_controller
  networking_istio = local.networking_istio
  networking_cillium = local.networking_cillium
  networking_cert_manager = local.networking_cert_manager
  networking_metallb = local.networking_metallb

  # OBSERVABILITY
  observability_kube_prometheus_stack = local.observability_kube_prometheus_stack
  observability_elasticsearch = local.observability_elasticsearch
  observability_kibana = local.observability_kibana
  observability_fluentd = local.observability_fluentd
  observability_loki_stack = local.observability_loki_stack

  # SECURITY
  security_vault = local.security_vault

}

# data "aws_secretsmanager_secret_version" "labcreds" {
#     secret_id = "labcreds"
# }

# labcreds = jsondecode(data.aws_secretsmanager_secret_version.labcreds.secret_string[""])