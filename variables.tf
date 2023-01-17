variable "environment" {
  type = string
}

variable "project_id" {
  type = string
}

variable "application" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "aws_region" {
  type= string
}

variable "aws_profile" {
  type= string
}

variable "aws_destination_account_assume_role_arn" {
  type= string
}

variable "kind_cluster_config_path" {
  type= string
}

variable "kind_cluster_context" {
  type= string
}

# CICD
variable "cicd_argocd" {
}

variable "cicd_argocd_apps" {
  
}

variable "cicd_argo_rollouts" {
  
}

# NETWORKING
variable "networking_nginx_ingress_controller" {
}

variable "networking_ambassador_ingress_controller" {
  
}

variable "networking_istio" {
  
}

variable "networking_cillium" {
  
}

variable "networking_metallb" {
  
}

variable "networking_cert_manager" {
  
}

# OBSERVABILITY
variable "observability_kube_prometheus_stack" {
  
}

variable "observability_elasticsearch" {
  
}

variable "observability_kibana" {
  
}

variable "observability_fluentd" {
  
}

variable "observability_loki_stack" {
  
}

# SECURITY
variable "security_vault" {
  
}