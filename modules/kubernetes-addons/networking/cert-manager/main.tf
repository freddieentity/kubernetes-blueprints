resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.6.0"
  wait = false
  timeout   = "1200"

  namespace        = "cert-manager"
  create_namespace = true

  # set {
  #   name = "installCRDs"
  #   value = false
  # }
  
  values = ["${file("${path.module}/cert-manager-values.yaml")}"]
}

resource "null_resource" "wait_for_cert_manager" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Cert Manager...\n"
      kubectl wait --namespace ${helm_release.cert_manager.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.cert_manager]
}