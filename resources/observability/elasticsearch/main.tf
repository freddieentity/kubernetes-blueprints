resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana/loki-stack"
  version    = "2.8.0"
  wait = false
  timeout   = "1200"

  namespace        = var.namespace

#   values = [file("nginx-ingress-controller-values.yaml")]
}

resource "null_resource" "wait_for_loki" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Loki stack ...\n"
      kubectl wait --namespace ${var.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.loki]
}