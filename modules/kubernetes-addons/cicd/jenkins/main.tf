resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = "4.3.0"
  namespace = "jenkins"
  create_namespace = true
  wait = false
  timeout   = "1200"

  values = var.values
}

resource "null_resource" "wait_for_jenkins" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for Jenkins...\n"
      kubectl wait --namespace ${helm_release.jenkins.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance \
        --timeout=360s
      echo "**|X|** Jenkins Information"
      echo "Jenkins Username: admin | Password: $(kubectl get secret -n jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)"
    EOF
  }

  depends_on = [helm_release.jenkins]
}