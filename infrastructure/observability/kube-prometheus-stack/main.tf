module "prometheus" {
  source = "../../../resources/observability/prometheus"
  namespace = var.namespace
}