resource "helm_release" "jfrog" {
  name       = "jfrog"
  repository = "https://charts.jfrog.io"
  chart      = "jfrog-platform"
  version    = "5.0.3"
  namespace = "jfrog"
  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_jfrog" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Argo CD...\n"
      kubectl wait --namespace ${helm_release.jfrog.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
      EOF
  }

  depends_on = [helm_release.jfrog]
}