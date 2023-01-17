# CICD
module "argocd" {
  source = "./cicd/argocd"

  count = var.cicd_argocd.enable ? 1 : 0
  values = var.cicd_argocd.values
}

module "argocd_apps" {
  source = "./cicd/argocd-apps"

  count = var.cicd_argocd_apps.enable ? 1 : 0
  values = var.cicd_argocd_apps.values
}

module "argo_rollouts" {
  source = "./cicd/argo-rollouts"

  count = var.cicd_argo_rollouts.enable ? 1 : 0
  values = var.cicd_argo_rollouts.values
}

module "gitea" {
  source = "./cicd/gitea"

  count = var.cicd_gitea.enable ? 1 : 0
  values = var.cicd_gitea.values
}

module "tekton" {
  source = "./cicd/tekton"

  count = var.cicd_tekton.enable ? 1 : 0
  values = var.cicd_tekton.values
}

# Networking
module "nginx_ingress_controller" {
  source = "./networking/nginx-ingress-controller"

  count = var.networking_nginx_ingress_controller.enable ? 1 : 0
  values = var.networking_nginx_ingress_controller.values
}

module "ambassador_ingress_controller" {
  source = "./networking/nginx-ingress-controller"

  count = var.networking_ambassador_ingress_controller.enable ? 1 : 0
  values = var.networking_ambassador_ingress_controller.values
}

module "cillium" {
  source = "./networking/cillium"

  count = var.networking_cillium.enable ? 1 : 0
  values = var.networking_cillium.values
}

module "istio" {
  source = "./networking/istio"

  count = var.networking_istio.enable ? 1 : 0
  values = var.networking_istio.values
}

module "cert_manager" {
  source = "./networking/cert-manager"

  count = var.networking_cert_manager.enable ? 1 : 0
  values = var.networking_cert_manager.values
}

module "metallb" {
  source = "./networking/metallb"

  count = var.networking_metallb.enable ? 1 : 0
  values = var.networking_metallb.values
}

# Observability
module "kube_prometheus_stack" {
  source = "./observability/kube-prometheus-stack"

  count = var.observability_kube_prometheus_stack.enable ? 1 : 0
  values = var.observability_kube_prometheus_stack.values
}

module "elasticsearch" {
  source = "./observability/elasticsearch"

  count = var.observability_elasticsearch.enable ? 1 : 0
  # values = var.observability_elasticsearch.values
}

module "kibana" {
  source = "./observability/kibana"

  count = var.observability_kibana.enable ? 1 : 0
  # values = var.observability_kibana.values
}

module "loki_stack" {
  source = "./observability/loki-stack"

  count = var.observability_loki_stack.enable ? 1 : 0
  values = var.observability_loki_stack.values
}

# Security

# module "aws_secret_manager" {
#   source = "./security/aws-secret-manager"

#   count = var.security_aws_secret_manager.enable ? 1 : 0
#   values = var.security_aws_secret_manager.values
# }

module "vault" {
  source = "./security/vault"

  count = var.security_vault.enable ? 1 : 0
  values = var.security_vault.values
}

module "opa" {
  source = "./security/opa"

  count = var.security_opa.enable ? 1 : 0
  values = var.security_opa.values
}