resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.6.0"
  wait      = false
  timeout   = "1200"

  create_namespace = true
  namespace        = var.namespace

  values = var.values
}

# resource "null_resource" "wait_for_promtail" {
#   triggers = {
#     key = uuid()
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for the Loki stack ...\n"
#       kubectl wait --namespace ${var.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=90s
#     EOF
#   }

#   depends_on = [helm_release.promtail]
# }