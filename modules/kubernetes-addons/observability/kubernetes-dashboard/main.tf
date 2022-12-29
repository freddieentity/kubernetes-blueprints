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

resource "helm_release" "kubernetes_dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "0.13.7"
  wait = false
  timeout   = "1200"

  namespace        = var.namespace

#   values = [file("kubernetes-dashboard-values.yaml")]
}

resource "null_resource" "wait_for_kubernetes_dashboard" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Kubernetes dashboard...\n"
      kubectl wait --namespace ${var.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.kubernetes_dashboard]
}