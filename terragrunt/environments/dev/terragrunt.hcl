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
# local.common.locals.tags

inputs = {
//   region = "us-east-1"
  kind_cluster_context = "kind-homelab"
  # CICD
  cicd_argocd = { enable = true, values = ["/values/argocd-values.yaml"]}
  # cicd_argocd_apps = { enable = true, values = ["/values/loki-stack-values.yaml"]}
  # cicd_argo_rollouts = { enable = true, values = ["/values/loki-stack-values.yaml"]}

  # NETWORKING
  networking_nginx_ingress_controller = { enable = true, values = ["/values/nginx-ingress-controller-values.yaml"]}
  networking_cert_manager = { enable = true, values = ["/values/cert-manager-values.yaml"]}

  # OBSERVABILITY
  observability_kube_prometheus_stack = { enable = true, values = ["/values/kube-prometheus-stack-values.yaml"]}
  # observability_elasticsearch = { enable = true, values = ["/values/loki-stack-values.yaml"]}
  # observability_kibana = { enable = true, values = ["/values/loki-stack-values.yaml"]}
  # observability_fluentd = { enable = true, values = ["/values/loki-stack-values.yaml"]}
  observability_loki_stack = { enable = true, values = ["/values/loki-stack-values.yaml"]}

  # SECURITY
  # security_vault = { enable = true, values = ["/values/loki-stack-values.yaml"]}
}