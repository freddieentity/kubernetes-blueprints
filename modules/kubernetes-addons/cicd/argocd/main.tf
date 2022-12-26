resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.8"
  namespace = "argocd"
  create_namespace = true
  wait = false
  timeout   = "1200"

  values = ["${file("${path.module}/argocd-values.yaml")}"]
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
      echo "**|X|** ArgoCD Information"
      echo "ArgoCD Username: admin | Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)"
    EOF
  }

  depends_on = [helm_release.argocd]
}