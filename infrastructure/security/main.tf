module "aws_secret_manager" {
  source = "../../resources/security/aws-secret-manager"

  count = var.enable_security_aws_secret_manager ? 1 : 0
}

module "vault" {
  source = "../../resources/security/vault"

  count = var.enable_security_vault ? 1 : 0
}

module "opa" {
  source = "../../resources/security/opa"

  count = var.enable_security_opa ? 1 : 0
}