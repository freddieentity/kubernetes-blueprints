resource "helm_release" "argocd_image_updater" {
  name       = "argocd-image-updater"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-image-updater"
  version    = "0.8.1"
  namespace = "argocd"

  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_argocd_image_updater" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for ArgoCD Image Updater...\n"
      kubectl wait --namespace ${helm_release.argocd_image_updater.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.argocd_image_updater]
}