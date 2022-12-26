# CICD

variable "enable_cicd_argocd" {
  default = false
  type = bool
}

variable "enable_cicd_tekton" {
  default = false
  type = bool
}

# Networking

variable "enable_networking_nginx_ingress_controller" {
  default = false
  type = bool
}

variable "enable_networking_cert_manager" {
  default = false
  type = bool
}

# Observability
variable "enable_observability_kube_prometheus_stack" {
  default = false
  type = bool
}

variable "enable_observability_elasticsearch" {
  default = false
  type = bool 
}

variable "enable_observability_kibana" {
  default = false
  type = bool 
}

variable "enable_observability_fluentd" {
  default = false
  type = bool 
}

# Security

variable "enable_security_aws_secret_manager" {
  default = false
  type = bool
}

variable "enable_security_vault" {
  default = false
  type = bool
}

variable "enable_security_opa" {
  default = false
  type = bool
}

