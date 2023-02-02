module "approle" {
  source = "./approle"
}

module "aws" {
  source = "./aws"

  aws_access_key              = var.aws_access_key
  aws_secret_key              = var.aws_secret_key
  aws_secret_engine_path_name = var.aws_secret_engine_path_name
  aws_secret_engine_role_name = var.aws_secret_engine_role_name
}

# module "azure" {
#   source = "./azure"

#   azure_subscription_id      = var.azure_subscription_id
#   azure_tenant_id            = var.azure_tenant_id
#   azure_client_id            = var.azure_client_id
#   azure_client_secret        = var.azure_client_secret
#   azure_vault_resource_group = var.azure_vault_resource_group
# }