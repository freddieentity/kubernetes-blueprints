resource "kubernetes_manifest" "kubernetes_dashboard" {
    manifest = yamldecode(file("${path.module}/manifests/kubernetes-dashboard.yaml"))
}