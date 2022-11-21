terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }
  }
}

provider "helm" {
  kubernetes {
    # host                   = var.kubernetes_cluster_endpoint
    # cluster_ca_certificate = base64decode(var.kubernetes_kube_config)
    config_path = pathexpand(var.kind_cluster_config_path)
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}

provider "aws" {
  region = var.region
}