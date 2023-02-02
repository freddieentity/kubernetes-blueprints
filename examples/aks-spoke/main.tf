module "aks_spoke" {
  source         = "../../modules/azure/aks-spoke"
  project_id     = var.project_id
  application    = var.application
  azure_location = var.azure_location

  resource_group_name = var.resource_group_name
  kubernetes_version = var.kubernetes_version
  vnetcidr            = var.vnetcidr
  subnetcidr          = var.subnetcidr

  agent_pools = var.agent_pools

  ssh_public_key         = var.ssh_public_key
  windows_admin_username = var.windows_admin_username
  windows_admin_password = var.windows_admin_password
}