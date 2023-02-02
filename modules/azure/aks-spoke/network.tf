# HUB and SPOKES IP Planning https://www.acendri-solutions.com/post/azure-hub-spoke-virtual-network-design-best-practices
# HUB
# resource "azurerm_resource_group" "hub" {
#   name     = "hub-rg"
#   location = var.azure_location
# }

# resource "azurerm_virtual_network" "hub" {
#   name                = "hub-vnet"
#   resource_group_name = azurerm_resource_group.hub.name
#   location            = azurerm_resource_group.hub.location
#   address_space       = var.vnetcidr
# }

# resource "azurerm_subnet" "hub_firewall" {
#   name                 = "hub-firewall-subnet"
#   resource_group_name  = azurerm_resource_group.hub.name
#   virtual_network_name = azurerm_virtual_network.hub.name
#   address_prefixes     = var.subnetcidr
# }

# resource "azurerm_subnet" "hub_pam" {
#   name                 = "hub-pam-subnet"
#   resource_group_name  = azurerm_resource_group.hub.name
#   virtual_network_name = azurerm_virtual_network.hub.name
#   address_prefixes     = var.subnetcidr
# }

# resource "azurerm_subnet" "hub_gateway_to_on_premises" {
#   name                 = "hub-gateway-to-on-premises-subnet"
#   resource_group_name  = azurerm_resource_group.hub.name
#   virtual_network_name = azurerm_virtual_network.hub.name
#   address_prefixes     = var.subnetcidr
# }

# SPOKE - AKS
resource "azurerm_resource_group" "spoke_aks" {
  name     = "${local.name}-rg"
  location = var.azure_location
}

resource "azurerm_virtual_network" "spoke_aks" {
  name                = "${local.name}-vnet"
  resource_group_name = azurerm_resource_group.spoke_aks.name
  location            = azurerm_resource_group.spoke_aks.location
  address_space       = var.vnetcidr
}

resource "azurerm_subnet" "spoke_aks" {
  name                 = "${local.name}-subnet"
  resource_group_name  = azurerm_resource_group.spoke_aks.name
  virtual_network_name = azurerm_virtual_network.spoke_aks.name
  address_prefixes     = var.subnetcidr
}

# resource "azurerm_subnet" "spoke_aks_private_endpoints" {
#   name                 = "${local.name}-subnet-private-endpoints"
#   resource_group_name  = azurerm_resource_group.spoke_aks.name
#   virtual_network_name = azurerm_virtual_network.spoke_aks.name
#   address_prefixes     = var.subnetcidr
# }

# resource "azurerm_subnet" "spoke_aks_lb" {
#   name                 = "${local.name}-subnet-lb"
#   resource_group_name  = azurerm_resource_group.spoke_aks.name
#   virtual_network_name = azurerm_virtual_network.spoke_aks.name
#   address_prefixes     = var.subnetcidr
# }

# resource "azurerm_subnet" "spoke_aks_waf" {
#   name                 = "${local.name}-subnet-waf"
#   resource_group_name  = azurerm_resource_group.spoke_aks.name
#   virtual_network_name = azurerm_virtual_network.spoke_aks.name
#   address_prefixes     = var.subnetcidr
# }
