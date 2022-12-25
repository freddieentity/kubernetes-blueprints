resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elastic/elasticsearch"
  version    = "8.5.1"
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

  depends_on = [helm_release.elasticsearch]
}