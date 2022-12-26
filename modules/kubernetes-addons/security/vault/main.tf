resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.23.0"
  wait = false
  timeout   = "1200"
  create_namespace = true

  namespace        = var.namespace

  values = ["${file("${path.module}/vault-values.yaml")}"]
}

# resource "null_resource" "wait_for_vault" {
#   triggers = {
#     key = uuid()
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for Vault...\n"
#       kubectl wait --namespace ${var.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=90s
#     EOF
#   }

#   depends_on = [helm_release.vault]
# }