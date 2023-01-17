resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace

    # annotations = {
    #   name = "example-annotation"
    # }

    labels = {
      monitoring = "prometheus"
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prom"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "41.7.0"
  namespace =   var.namespace

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