resource "azurerm_kubernetes_cluster" "main" {
  name                = "${local.name}-aks"
  location            = azurerm_resource_group.spoke_aks.location
  resource_group_name = azurerm_resource_group.spoke_aks.name
  kubernetes_version = var.kubernetes_version
  dns_prefix          = "${local.name}-aks"
  #   node_resource_group = azurerm_resource_group.spoke_aks.name


  default_node_pool {
    name            = var.agent_pools.name
    node_count      = var.agent_pools.count
    vm_size         = var.agent_pools.vm_size
    os_disk_size_gb = var.agent_pools.os_disk_size_gb
  }

  identity {
    type = "SystemAssigned"
  }

  #   service_principal {
  #     client_id     = data.azurerm_key_vault_secret.spn_id.value
  #     client_secret = data.azurerm_key_vault_secret.spn_secret.value
  #   }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  azure_policy_enabled = true

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  }

  # ingress_application_gateway { # Alternative for Ingress Nginx Controller
  #   subnet_id = azurerm_subnet.spoke_aks.id
  # }

  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }

  linux_profile {
    admin_username = var.windows_admin_username
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }
  # role_based_access_control_enabled = true
  # azure_active_directory_role_based_access_control {
  #   managed                = true
  #   admin_group_object_ids = [azuread_group.aks_administrators.id]
  # }


  tags = {
    Environment = var.environment
    Name = "${local.name}-aks"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = 0.5 # note: this is the "maximum" price
  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]
}

# Log

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${local.name}-insights"
  location            = azurerm_resource_group.spoke_aks.location
  resource_group_name = azurerm_resource_group.spoke_aks.name
  retention_in_days   = 30
}

# ACR

resource "azurerm_container_registry" "main" {
  name                = "freddieentity"
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
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity.0.object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id 
  skip_service_principal_aad_check = true
}
