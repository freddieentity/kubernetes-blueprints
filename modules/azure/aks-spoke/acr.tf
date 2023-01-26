resource "azurerm_container_registry" "main" {
  name                = "${var.application}registry"
  resource_group_name = azurerm_resource_group.spoke_aks.name
  location            = azurerm_resource_group.spoke_aks.location
  sku                 = "Basic"
  admin_enabled       = false
  #   georeplications {
  #     location                = "East US"
  #     zone_redundancy_enabled = true
  #     tags                    = {}
  #   }
}

resource "azurerm_role_assignment" "main" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}
