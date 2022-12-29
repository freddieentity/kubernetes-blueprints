resource "helm_release" "argocd_rollouts" {
  name       = "argorollouts"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "2.21.0"
  namespace = "argocd"

  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_argocd_rollouts" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Argo Rollouts...\n"
      kubectl wait --namespace ${helm_release.argocd_rollouts.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.argocd_rollouts]
}