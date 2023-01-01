# module "eks" {

# }

module "kubernetes_addons" {
  source = "./modules/kubernetes-addons"

  # CICD
  cicd_argocd = { enable = true, values = ["${file("${path.module}/values/argocd-values.yaml")}"]}
  # cicd_argocd_apps = true
  # cicd_argo_rollouts = true

  # NETWORKING
  networking_nginx_ingress_controller = { enable = true, values = ["${file("${path.module}/values/nginx-ingress-controller-values.yaml")}"]}
  # networking_istio = { enable = true, values = ["${file("${path.module}/values/istio-values.yaml")}"]}
  # networking_cillium = { enable = true, values = ["${file("${path.module}/values/cillium-values.yaml")}"]}
  # networking_cert_manager = { enable = true, values = ["${file("${path.module}/values/cert-manager-values.yaml")}"]}

  # OBSERVABILITY
  observability_kube_prometheus_stack = { enable = true, values = ["${file("${path.module}/values/kube-prometheus-stack-values.yaml")}"]}
  # observability_elasticsearch = true
  # observability_kibana = true
  # observability_fluentd = true
  # observability_loki_stack = { enable = true, values = ["${file("${path.module}/values/loki-stack-values.yaml")}"]}

  # SECURITY
  # security_vault = true

}

# data "aws_secretsmanager_secret_version" "labcreds" {
#     secret_id = "labcreds"
# }

# labcreds = jsondecode(data.aws_secretsmanager_secret_version.labcreds.secret_string[""])