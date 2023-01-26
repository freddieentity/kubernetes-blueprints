project_id     = "m"
application    = "mini"
azure_location = "eastus2"

resource_group_name = "myrg"
vnetcidr            = ["10.0.0.0/24"]
subnetcidr          = ["10.0.0.0/25"]

agent_pools = {
  name            = "pool1"
  count           = 1
  vm_size         = "Standard_D2_v2"
  os_disk_size_gb = "30"
}

ssh_public_key         = "~/.ssh/id_rsa.pub"
windows_admin_username = "azureuser"
windows_admin_password = "P@ssw0rd123456" 