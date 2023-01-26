# resource "azuread_group" "aks_administrators" {
#   display_name     = "${azurerm_resource_group.spoke_aks.name}-aks-administrators"
#   security_enabled = true
#   description      = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.spoke_aks.name} cluster."
# }
