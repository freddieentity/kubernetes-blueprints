# module "eks" {

# }

module "kubernetes_addons" {
  source = "../../modules/kubernetes-addons"

  # CICD
  cicd_argocd = { enable = true, values = ["${file("${path.module}/values/argocd-values.yaml")}"]}
  # enable_cicd_argocd_apps = true
  # enable_cicd_argo_rollouts = true

  # NETWORKING
  networking_nginx_ingress_controller = { enable = true, values = ["${file("${path.module}/values/nginx-ingress-controller-values.yaml")}"]}
  networking_cert_manager = { enable = true, values = ["${file("${path.module}/values/cert-manager-values.yaml")}"]}

  # OBSERVABILITY
  observability_kube_prometheus_stack = { enable = true, values = ["${file("${path.module}/values/kube-prometheus-stack-values.yaml")}"]}
  # enable_observability_elasticsearch = true
  # enable_observability_kibana = true
  # enable_observability_fluentd = true
  observability_loki_stack = { enable = true, values = ["${file("${path.module}/values/loki-stack-values.yaml")}"]}

  # SECURITY
  # enable_security_vault = true
}
