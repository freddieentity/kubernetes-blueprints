resource "helm_release" "prometheus" {
  name       = "prom"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "41.7.0"
  namespace = var.namespace
  create_namespace = true
  timeout   = "1200"
  values = ["${file("${path.module}/kube-prometheus-stack-values.yaml")}"]
}

resource "null_resource" "wait_for_prometheus" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Prometheus monitoring...\n"
      kubectl wait --namespace ${helm_release.prometheus.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
    EOF
  }

  depends_on = [helm_release.prometheus]
}