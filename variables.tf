variable "aws_region" {
  default = "us-east-1"
  type= string
}

variable "aws_profile" {
  default = "default"
  type= string
}

variable "aws_destination_account_assume_role_arn" {
  default = "arn:aws:iam::158904540988:role/destination_assume_role"
  type= string
}

variable "kind_cluster_config_path" {
  default = "~/.kube/config"
  type= string
}

variable "kind_cluster_context" {
  type= string
}