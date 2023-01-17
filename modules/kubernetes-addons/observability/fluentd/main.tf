resource "null_resource" "fluentd_apply" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = "kubectl apply -f ${path.module}"
  }
}
# resource "helm_release" "fluentd" {
#   name       = "fluentd"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "bitnami/fluentd"
#   version    = "5.0.0"
#   wait = false
#   timeout   = "1200"

#   namespace        = var.namespace

# #   values = [file("nginx-ingress-controller-values.yaml")]
# }

# resource "null_resource" "wait_for_fluentd" {
#   triggers = {
#     key = uuid()
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for the Fluentd...\n"
#       kubectl wait --namespace ${var.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=90s
#     EOF
#   }

#   depends_on = [helm_release.fluentd]
# }