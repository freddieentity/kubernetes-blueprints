variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "us-east-1" }
variable "path" { default = "../vault-config/terraform.tfstate" }
variable "ttl" { default = "1" }
variable "vault_address" { default = "http:/127.0.0.1:8200" }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "vault" {
  address = var.vault_address
}

data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = var.path
  }
}

data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.role
}

provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = "ami-06878d265978313ca"
  instance_type = "t2.nano"

  tags = {
    Name  = var.name
    TTL   = var.ttl
    owner = "${var.name}-guide"
  }
}

# resource "aws_s3_bucket" "b" {
#   bucket = "freddieentity-bucket-vault"
# }