variable "vault_address" {}
variable "vault_token" {}
# AWS
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_secret_engine_path_name" {}
variable "aws_secret_engine_role_name" {}
# Azure
variable "azure_subscription_id" {
  description = "Azure subscription_id"
}

variable "azure_tenant_id" {
  description = "Azure tenant_id"
}

variable "azure_client_secret" {
  description = "Azure client_secret"
}

variable "azure_client_id" {
  description = "Azure client_id"
}

variable "azure_vault_resource_group" {}

