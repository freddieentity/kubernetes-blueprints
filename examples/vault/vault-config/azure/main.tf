# Azure Secrets Engine Configuration
resource "vault_azure_secret_backend" "azure" {
  subscription_id = var.azure_subscription_id
  tenant_id = var.azure_tenant_id
  client_secret = var.azure_client_secret
  client_id = var.azure_client_id
}

resource "vault_azure_secret_backend_role" "admin_vm" {
  backend                     = vault_azure_secret_backend.azure.path
  role                        = "admin-vm"
  ttl                         = "24h"
  max_ttl                     = "48h"

  azure_roles {
    role_name = "Contributor"
    scope =  "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_vault_resource_group}"
  }
}