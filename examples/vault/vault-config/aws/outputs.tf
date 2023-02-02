output "vault_aws_secret_backend_aws_path" {
  value = vault_aws_secret_backend.aws.path
}

output "vault_aws_secret_backend_role_admin_ec2_name" {
  value = vault_aws_secret_backend_role.admin_ec2.name
}