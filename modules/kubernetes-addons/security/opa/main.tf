resource "kubernetes_namespace" "tekton" {
  metadata {
    name = "tekton"
  }
}

resource "helm_release" "tekton" {
  name       = "tekton"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.8"
  namespace = kubernetes_namespace.tekton.id
  wait = false
  timeout   = "1200"
  values    = var.values
}

resource "null_resource" "wait_for_tekton" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Argo CD...\n"
      kubectl wait --namespace ${helm_release.tekton.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.tekton]
}