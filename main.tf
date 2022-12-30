# module "eks" {

# }

module "kubernetes_addons" {
  source = "./modules/kubernetes-addons"

  # All the variables will then be filled correspondingly by Terragrunt hcl in folder /terragrunt/environments/*
}

# data "aws_secretsmanager_secret_version" "labcreds" {
#     secret_id = "labcreds"
# }

# labcreds = jsondecode(data.aws_secretsmanager_secret_version.labcreds.secret_string[""])