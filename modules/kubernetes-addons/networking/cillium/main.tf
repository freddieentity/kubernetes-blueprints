resource "helm_release" "cillium" {
  name       = "cilium"
  chart      = "cilium"
  repository = "https://helm.cilium.io/"
  version    = "1.12.3"
  namespace  = "kube-system"
  values =  var.values
}

resource "null_resource" "wait_for_cillium" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Cillium...\n"
      kubectl wait --namespace ${helm_release.cillium.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.cillium]
}