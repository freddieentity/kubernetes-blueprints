module "eks" {
  source = "./modules/aws/eks"
}

module "kubernetes_addons" {
  source = "./modules/kubernetes-addons"

  # MANAGEMENT
  management_keda = local.management_keda

  # CICD
  cicd_argocd        = local.cicd_argocd
  cicd_argocd_apps   = local.cicd_argocd_apps
  cicd_argo_rollouts = local.cicd_argo_rollouts
  cicd_jenkins       = local.cicd_jenkins
  cicd_gitea         = local.cicd_gitea

  # NETWORKING
  networking_nginx_ingress_controller      = local.networking_nginx_ingress_controller
  networking_ambassador_ingress_controller = local.networking_ambassador_ingress_controller
  networking_istio                         = local.networking_istio
  networking_cillium                       = local.networking_cillium
  networking_cert_manager                  = local.networking_cert_manager
  networking_metallb                       = local.networking_metallb

  # OBSERVABILITY
  observability_kube_prometheus_stack = local.observability_kube_prometheus_stack
  observability_elasticsearch         = local.observability_elasticsearch
  observability_kibana                = local.observability_kibana
  observability_fluentd               = local.observability_fluentd
  observability_loki_stack            = local.observability_loki_stack

  # SECURITY
  security_vault = local.security_vault

}

# data "aws_secretsmanager_secret_version" "labcreds" {
#     secret_id = "labcreds"
# }

# labcreds = jsondecode(data.aws_secretsmanager_secret_version.labcreds.secret_string[""])


# COMMUNITY MODULES
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "3.19.0"

#   name = "education-vpc"

#   cidr = "10.0.0.0/16"
#   azs  = slice(data.aws_availability_zones.available.names, 0, 3)

#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

#   enable_nat_gateway   = true
#   single_nat_gateway   = true
#   enable_dns_hostnames = true

#   public_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                      = 1
#   }

#   private_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"             = 1
#   }
# }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.5.1"

#   cluster_name    = local.cluster_name
#   cluster_version = "1.24"

#   vpc_id                         = module.vpc.vpc_id
#   subnet_ids                     = module.vpc.private_subnets
#   cluster_endpoint_public_access = true

#   eks_managed_node_group_defaults = {
#     ami_type = "AL2_x86_64"

#   }

#   eks_managed_node_groups = {
#     one = {
#       name = "node-group-1"

#       instance_types = ["t3.small"]

#       min_size     = 1
#       max_size     = 3
#       desired_size = 2
#     }

#     two = {
#       name = "node-group-2"

#       instance_types = ["t3.small"]

#       min_size     = 1
#       max_size     = 2
#       desired_size = 1
#     }
#   }
# }