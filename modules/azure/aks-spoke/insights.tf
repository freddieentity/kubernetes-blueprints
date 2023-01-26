resource "azurerm_log_analytics_workspace" "main" {
  name                = "${local.name}-insights"
  location            = azurerm_resource_group.spoke_aks.location
  resource_group_name = azurerm_resource_group.spoke_aks.name
  retention_in_days   = 30
}
