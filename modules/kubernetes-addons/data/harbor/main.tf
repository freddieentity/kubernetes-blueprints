resource "helm_release" "gitea" {
  name       = "gitea"
  repository = "https://dl.gitea.io/charts/"
  chart      = "gitea"
  version    = "5.0.3"
  namespace = "gitea"
  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_gitea" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Argo CD...\n"
      kubectl wait --namespace ${helm_release.gitea.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
      EOF
  }

  depends_on = [helm_release.gitea]
}