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
    config_context = var.kind_cluster_context
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
  config_context = var.kind_cluster_context
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment     = "Test"
      ProjectID     = "Test"
      Application         = "Example"
      CostCenter = "aws-default-tags"
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
  assume_role {
    role_arn = var.aws_destination_account_assume_role_arn
  }
}