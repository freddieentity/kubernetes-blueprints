remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "freddieentity-remote-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    // encrypt        = true
    // dynamodb_table = "my-lock-table"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
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
  region = var.region
}
EOF
}

// extra_arguments "custom_vars" {
//   commands = [
//     "apply",
//     "plan",
//     "import",
//     "push",
//     "refresh"
//   ]
//   // # With the get_terragrunt_dir() function, you can use relative paths!
//   // // arguments = [
//   // //     "-var-file=${get_terragrunt_dir()}/../common.tfvars",
//   // //     "-var-file=example.tfvars"
//   // // ]
// }