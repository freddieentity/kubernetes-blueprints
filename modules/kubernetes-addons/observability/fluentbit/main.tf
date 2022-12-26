resource "helm_release" "elaticsearch" {
  name       = "elasticsearch"
  repository = "elastic/elasticsearch"
  chart      = "elasticsearch"
  version    = "7.9.3"
  wait = false
  timeout   = "1200"

  namespace        = var.namespace

#   values = [file("nginx-ingress-controller-values.yaml")]
}

resource "null_resource" "wait_for_elasticsearch" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the Elasticsearch...\n"
      kubectl wait --namespace ${var.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.elaticsearch]
}