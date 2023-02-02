resource "helm_release" "keda" {
  name       = "keda"
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  version    = "2.9.2"
  namespace = "keda"
  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_keda" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for KEDA...\n"
      kubectl wait --namespace ${helm_release.keda.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.keda]
}