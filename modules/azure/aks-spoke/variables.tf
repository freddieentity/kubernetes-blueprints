variable "environment" {
  type = string
  default = "dev"
}

variable "project_id" {
  type = string
}

variable "application" {
  type = string
}

variable "azure_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "vnetcidr" {
  type = list(any)
}

variable "subnetcidr" {
  type = list(any)
}

variable "agent_pools" {
  type = object({
    name            = string
    count           = number
    vm_size         = string
    os_disk_size_gb = string
    }
  )
}

variable "ssh_public_key" {
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"
}

# Windows Admin Username for k8s worker nodes
variable "windows_admin_username" {
  type        = string
  description = "This variable defines the Windows admin username k8s Worker nodes"
}

# Windows Admin Password for k8s worker nodes
variable "windows_admin_password" {
  type        = string
  description = "This variable defines the Windows admin password k8s Worker nodes"
}
