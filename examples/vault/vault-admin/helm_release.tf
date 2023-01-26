resource "helm_release" "vault" {
  name       = "vault"
  # repository = "https://kubernetes-charts.banzaicloud.com" # https://banzaicloud.com/docs/bank-vaults/operator/
  # chart      = "vault-operator"
  repository = "https://helm.releases.hashicorp.com" # https://banzaicloud.com/docs/bank-vaults/operator/
  chart      = "vault"
  version    = "0.23.0"
  wait = false
  timeout   = "1200"
  create_namespace = true

  namespace        = "vault"

  values = var.values
}

resource "null_resource" "wait_for_vault" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Vault...\n"
      kubectl wait --namespace vault \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/name=vault \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.vault]
}