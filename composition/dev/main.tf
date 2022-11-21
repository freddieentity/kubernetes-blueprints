

# module "network" {
#   source = "../../infrastructure/network"
# }

# module "monitoring" {
#   source = "../../infrastructure/monitoring"
# }

module "cd" {
  source = "../../infrastructure/cd"
}

# module "ingress" { 
#   source = "../../resources/toolchain/nginx-ingress-controller"
# }

# module "logging" {
#   source = "../../infrastructure/logging"
# }