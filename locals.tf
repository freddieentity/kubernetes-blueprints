locals {
  # CICD
  cicd_argocd = { enable = var.cicd_argocd["enable"], values = [for value in var.cicd_argocd["values"] : "${file("${path.module}${value}")}" ]}
  cicd_argocd_apps = { enable = var.cicd_argocd_apps["enable"], values = [for value in var.cicd_argocd_apps["values"] : "${file("${path.module}${value}")}" ]}
  cicd_argo_rollouts = { enable = var.cicd_argo_rollouts["enable"], values = [for value in var.cicd_argo_rollouts["values"] : "${file("${path.module}${value}")}" ]}

  # NETWORKING
  networking_nginx_ingress_controller = { enable = var.networking_nginx_ingress_controller["enable"], values = [for value in var.networking_nginx_ingress_controller["values"] : "${file("${path.module}${value}")}" ]}
  networking_ambassador_ingress_controller = { enable = var.networking_ambassador_ingress_controller["enable"], values = [for value in var.networking_ambassador_ingress_controller["values"] : "${file("${path.module}${value}")}" ]}
  networking_istio = { enable = var.networking_istio["enable"], values = [for value in var.networking_istio["values"] : "${file("${path.module}${value}")}" ]}
  networking_cillium = { enable = var.networking_cillium["enable"], values = [for value in var.networking_cillium["values"] : "${file("${path.module}${value}")}" ]}
  networking_cert_manager = { enable = var.networking_cert_manager["enable"], values = [for value in var.networking_cert_manager["values"] : "${file("${path.module}${value}")}" ]}
  networking_metallb = { enable = var.networking_metallb["enable"], values = [for value in var.networking_metallb["values"] : "${file("${path.module}${value}")}" ]}

  # OBSERVABILITY
  observability_kube_prometheus_stack = { enable = var.observability_kube_prometheus_stack["enable"], values = [for value in var.observability_kube_prometheus_stack["values"] : "${file("${path.module}${value}")}" ]}
  observability_elasticsearch = { enable = var.observability_elasticsearch["enable"], values = [for value in var.observability_elasticsearch["values"] : "${file("${path.module}${value}")}" ]}
  observability_kibana = { enable = var.observability_kibana["enable"], values = [for value in var.observability_kibana["values"] : "${file("${path.module}${value}")}" ]}
  observability_fluentd = { enable = var.observability_fluentd["enable"], values = [for value in var.observability_fluentd["values"] : "${file("${path.module}${value}")}" ]}
  observability_loki_stack = { enable = var.observability_loki_stack["enable"], values = [for value in var.observability_loki_stack["values"] : "${file("${path.module}${value}")}" ]}

  # SECURITY
  security_vault = { enable = var.security_vault["enable"], values = [for value in var.security_vault["values"] : "${file("${path.module}${value}")}" ]}
}