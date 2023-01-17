resource "helm_release" "ingress_ambassador" {
  name       = "emissary-ingress"
  repository = "https://app.getambassador.io"
  chart      = "emissary-ingress"
  version    = "3.4.0"
  wait = false
  timeout   = "1200"

  namespace        = "emissary-ingress"
  create_namespace = true

  values = var.values
}

resource "null_resource" "wait_for_ingress_ambassador" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Ambassador ingress controller...\n"
      kubectl wait --namespace ${helm_release.ingress_ambassador.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.ingress_ambassador]
}