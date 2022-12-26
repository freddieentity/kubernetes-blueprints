resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "8.5.1"
  wait = false
  timeout   = "1200"

  create_namespace = true
  namespace        = var.namespace

#   values = [file(".yaml")]
}

# resource "null_resource" "wait_for_kibana" {
#   triggers = {
#     key = uuid()
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for the Kibana...\n"
#       kubectl wait --namespace ${var.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=90s
#     EOF
#   }

#   depends_on = [helm_release.kibana]
# }