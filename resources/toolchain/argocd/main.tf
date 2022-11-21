resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.8"
  namespace = kubernetes_namespace.argocd.id
  wait = false
  timeout   = "1200"
#   values    = [templatefile("${path.module}/templates/argocd-values.yaml"), {}]
}

resource "null_resource" "wait_for_argocd" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Argo CD...\n"
      kubectl wait --namespace ${helm_release.argocd.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.argocd]
}