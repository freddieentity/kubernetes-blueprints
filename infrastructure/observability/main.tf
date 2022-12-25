module "kube_prometheus_stack" {
  source = "./kube-prometheus-stack"

  count = var.enable_observability_kube_prometheus_stack ? 1 : 0
  namespace = var.namespace
}