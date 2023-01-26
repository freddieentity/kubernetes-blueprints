resource "helm_release" "kubewatch" {
  name       = "kubewatch"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kubewatch"
  version    = "41.7.0"
  namespace =   var.namespace
  create_namespace = true

  timeout   = "1800"
  values = var.values

  depends_on = [kubernetes_namespace.monitoring]
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