module "kube_prometheus_stack" {
  source = "../../../resources/observability/prometheus"
  namespace = var.namespace
}