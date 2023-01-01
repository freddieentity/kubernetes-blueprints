# resource "kubernetes_namespace" "istio_system" {
#   metadata {
#     name = var.namespace

#     # annotations = {
#     #   name = "example-annotation"
#     # }

#     # labels = {
#     #   istio-system = ""
#     # }
#   }
# }

# resource "helm_release" "istio_base" {
#   name       = "istio-base"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "base"
#   version    = "1.6.0"
#   wait = false
#   timeout   = "1200"

#   namespace        = var.namespace
  
#   # values = var.values
# }


# resource "helm_release" "istiod" {
#   name       = "istiod"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "istiod"
#   version    = "1.6.0"
#   wait = false
#   timeout   = "1200"

#   namespace        = var.namespace
  
#   # values = var.values
# }

# resource "helm_release" "istio_ingress" {
#   name       = "istio-ingress"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "gateway"
#   version    = "1.6.0"
#   wait = false
#   timeout   = "1200"

#   namespace        = var.namespace
  
#   # values = var.values
# }



# resource "null_resource" "wait_for_cert_manager" {
#   triggers = {
#     key = uuid()
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for the Cert Manager...\n"
#       kubectl wait --namespace ${helm_release.cert_manager.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=90s
#     EOF
#   }

#   depends_on = [helm_release.cert_manager]
# }