# CICD
module "argocd" {
  source = "./cicd/argocd"

  count = var.enable_cicd_argocd ? 1 : 0
}

module "tekton" {
  source = "./cicd/tekton"

  count = var.enable_cicd_tekton ? 1 : 0
}

# Networking
module "nginx_ingress_controller" {
  source = "./networking/nginx-ingress-controller"

  count = var.enable_networking_nginx_ingress_controller ? 1 : 0
}

module "cert_manager" {
  source = "./networking/cert-manager"

  count = var.enable_networking_cert_manager ? 1 : 0
}

# Observability
module "kube_prometheus_stack" {
  source = "./observability/kube-prometheus-stack"

  count = var.enable_observability_kube_prometheus_stack ? 1 : 0
}

module "elasticsearch" {
  source = "./observability/elasticsearch"

  count = var.enable_observability_elasticsearch ? 1 : 0
}

module "kibana" {
  source = "./observability/kibana"

  count = var.enable_observability_kibana ? 1 : 0
}

# Security

module "aws_secret_manager" {
  source = "./security/aws-secret-manager"

  count = var.enable_security_aws_secret_manager ? 1 : 0
}

module "vault" {
  source = "./security/vault"

  count = var.enable_security_vault ? 1 : 0
}

module "opa" {
  source = "./security/opa"

  count = var.enable_security_opa ? 1 : 0
}