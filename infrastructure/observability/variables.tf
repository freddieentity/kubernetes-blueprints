variable "namespace" {
  default = "monitoring"
}

variable "enable_observability_kube_prometheus_stack" {
  default = false
  type = bool
}

variable "enable_observability_efk_stack" {
  default = false
  type = bool
}

variable "enable_observability_lgtm_stack" {
  default = false
  type = bool
}