variable "environment" {}
variable "project_id" {}
variable "application" {}
variable "cost_center" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "aws_destination_account_assume_role_arn" {}
variable "kind_cluster_config_path" {}
variable "kind_cluster_context" {}

# AWS EKS
variable "cluster_name" {}
variable "vpc_cidr" {}
variable "azs" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "on_demand_instance_types" {}
variable "on_demand_min_size" {}
variable "on_demand_max_size" {}
variable "on_demand_desired_size" {}
variable "spot_instance_types" {}
variable "spot_min_size" {}
variable "spot_max_size" {}
variable "spot_desired_size" {}


# MANAGEMENT
variable "management_keda" {}

# CICD
variable "cicd_argocd" {}
variable "cicd_argocd_apps" {}
variable "cicd_argo_rollouts" {}
variable "cicd_jenkins" {}
variable "cicd_gitea" {}

# NETWORKING
variable "networking_nginx_ingress_controller" {}
variable "networking_ambassador_ingress_controller" {}
variable "networking_istio" {}
variable "networking_cillium" {}
variable "networking_metallb" {}
variable "networking_cert_manager" {}

# OBSERVABILITY
variable "observability_kube_prometheus_stack" {}
variable "observability_elasticsearch" {}
variable "observability_kibana" {}
variable "observability_fluentd" {}
variable "observability_loki_stack" {}

# SECURITY
variable "security_vault" {}