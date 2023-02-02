# Jenkins
resource "vault_policy" "jenkins_policy" {
  name = "jenkins-policy"
  policy = "${file("${path.module}/policies/jenkins_policy.hcl")}"
}

resource "vault_auth_backend" "jenkins_access" {
  type = "approle"
  path = "jenkins"
}

resource "vault_approle_auth_backend_role" "jenkins_approle" {
  backend            = vault_auth_backend.jenkins_access.path
  role_name          = "jenkins-approle"
  //secret_id_num_uses = "0"  means unlimited 
  secret_id_num_uses = "0" 
  token_policies     = ["default", "jenkins-policy"]
}

# Pipeline
resource "vault_policy" "pipeline_policy" {
  name = "pipeline-policy"
  policy = "${file("${path.module}/policies/jenkins_pipeline_policy.hcl")}"
}

resource "vault_auth_backend" "pipeline_access" {
  type = "approle"
  path = "pipeline"
}

resource "vault_approle_auth_backend_role" "pipeline_approle" {
  backend            = vault_auth_backend.pipeline_access.path
  role_name          = "pipeline-approle"
  secret_id_num_uses = "1"
  secret_id_ttl      = "300"
  token_ttl          = "1800"
  token_policies     = ["default", "pipeline-policy"]
}

# Webapp
resource "vault_auth_backend" "apps_access" {
  type = "approle"
  path = "approle"
}

resource "vault_approle_auth_backend_role" "webblog_approle" {
  backend            = vault_auth_backend.apps_access.path
  role_name          = "webblog-approle"
  secret_id_num_uses = "1"
  secret_id_ttl      = "600"
  token_ttl          = "1800"
  token_policies     = ["default", "webblog"]
}
