# variable "chart" {
#   type = string
#   default = "argo-cd"
# }

# variable "version" {
#   type = string
#   default = "5.16.0"
# }

# variable "namespace" {
#   default = "argocd"
#   type = string
# }

variable "values" {
  default = []
  type = list
}