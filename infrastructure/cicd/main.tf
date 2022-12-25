module "argocd" {
  source = "../../resources/cicd/argocd"

  count = var.enable_cicd_argocd ? 1 : 0
}

module "tekton" {
  source = "../../resources/cicd/tekton"

  count = var.enable_cicd_tekton ? 1 : 0
}