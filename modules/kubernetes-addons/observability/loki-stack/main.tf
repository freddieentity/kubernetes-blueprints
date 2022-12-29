resource "helm_release" "loki_stack" {
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.8.8"
  wait      = false
  timeout   = "1200"

  create_namespace = true
  namespace        = var.namespace

  values = var.values
}

# resource "null_resource" "wait_for_loki_stack" {
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

#   depends_on = [helm_release.loki_stack]
# }