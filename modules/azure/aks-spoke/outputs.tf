resource "null_resource" "aks_update_kubeconfig" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = "az aks get-credentials --resource-group ${azurerm_resource_group.spoke_aks.name} --name ${azurerm_kubernetes_cluster.main.name} --overwrite-existing"
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [azurerm_kubernetes_cluster.main]
}

# output "azure_ad_group_id" {
#   value = azuread_group.aks_administrators.id
# }
# output "azure_ad_group_objectid" {
#   value = azuread_group.aks_administrators.object_id
# }

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.main.kubernetes_version
}
