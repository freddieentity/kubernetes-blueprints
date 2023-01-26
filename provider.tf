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
    # host                   = data.aws_eks_cluster.main.endpoint
    # cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
    # exec {
    #   api_version = "client.authentication.k8s.io/v1alpha1"
    #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.main.name]
    #   command     = "aws"
    # }
    config_path    = pathexpand(var.kind_cluster_config_path)
    config_context = var.kind_cluster_context
  }
}

provider "kubernetes" {
  # host = data.aws_eks_cluster.main.endpoint
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
  # # client_certificate     = base64decode(var.client_certificate)
  # # client_key             = base64decode(var.client_key)
  
  config_path    = pathexpand(var.kind_cluster_config_path)
  config_context = var.kind_cluster_context
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = var.environment
      ProjectID   = var.project_id
      Application = var.application
      CostCenter  = var.cost_center
    }
  }
  # Usage for default tags
  # dynamic "tag" {
  #   for_each = data.aws_default_tags.current.tags
  #   content {
  #     key                 = tag.key
  #     value               = tag.value
  #     propagate_at_launch = true
  #   }
  # }
  # assume_role {
  #   role_arn = var.aws_destination_account_assume_role_arn
  # }
}