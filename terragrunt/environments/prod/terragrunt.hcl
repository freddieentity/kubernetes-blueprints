include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../.."

    // before_hook "select_workspace" {
    //     commands = ["init"]
    //     execute = ["terraform", "workspace", "select", "${local.workspace}"]
    // }
}

locals { common = read_terragrunt_config(find_in_parent_folders("common.hcl")) }

inputs = {
//   region = "us-east-2"
  kind_cluster_context = "kind-cnaa"
  # CICD
  cicd_argocd = { enable = true, values = ["/values/argocd-values.yaml"]}
  # enable_cicd_argocd_apps = true
  # enable_cicd_argo_rollouts = true

  # NETWORKING
  networking_nginx_ingress_controller = { enable = true, values = ["/values/nginx-ingress-controller-values.yaml"]}
  networking_cert_manager = { enable = true, values = ["/values/cert-manager-values.yaml"]}

  # OBSERVABILITY
  observability_kube_prometheus_stack = { enable = true, values = ["/values/kube-prometheus-stack-values.yaml"]}
  # enable_observability_elasticsearch = true
  # enable_observability_kibana = true
  # enable_observability_fluentd = true
  observability_loki_stack = { enable = true, values = ["/values/loki-stack-values.yaml"]}

  # SECURITY
  # enable_security_vault = true
}