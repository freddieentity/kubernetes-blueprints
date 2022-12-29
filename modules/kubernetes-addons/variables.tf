# CICD
variable "cicd_argocd" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "cicd_argocd_apps" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "cicd_argo_rollouts" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "cicd_tekton" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}
# Networking
variable "networking_nginx_ingress_controller" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "networking_cert_manager" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

# Observability
variable "observability_kube_prometheus_stack" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "observability_elasticsearch" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "observability_kibana" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "observability_fluentd" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "observability_loki_stack" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}
# Security
variable "security_aws_secret_manager" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "security_vault" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

variable "security_opa" {
  default = {enable = false, values = []}
  type = object({
    enable    = bool
    values = list(any)
  })
}

