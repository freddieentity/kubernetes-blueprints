resource "kubernetes_manifest" "deployment_logging_elasticsearch" {
  manifest = {
    apiVersion = "apps/v1"
    kind = "Deployment"
    metadata = {
      labels = {
        app = "elasticsearch"
      }
      name = "elasticsearch"
      namespace = "logging"
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app = "elasticsearch"
        }
      }
      template = {
        metadata = {
          labels = {
            app = "elasticsearch"
          }
        }
        spec = {
          containers = [
            {
              env = [
                {
                  name = "node.name"
                  value = "elasticsearch"
                },
                {
                  name = "cluster.initial_master_nodes"
                  value = "elasticsearch"
                },
                {
                  name = "bootstrap.memory_lock"
                  value = "false"
                },
                {
                  name = "ES_JAVA_OPTS"
                  value = "-Xms512m -Xmx512m"
                },
              ]
              image = "elasticsearch:7.9.1"
              imagePullPolicy = "IfNotPresent"
              name = "elasticsearch"
              ports = [
                {
                  containerPort = 9200
                },
              ]
            },
          ]
          initContainers = [
            {
              command = [
                "sysctl",
                "-w",
                "vm.max_map_count=262144",
              ]
              image = "busybox"
              name = "vm-max-fix"
              securityContext = {
                privileged = true
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_elasticsearch" {
  manifest = {
    apiVersion = "v1"
    kind = "Service"
    metadata = {
      labels = {
        app = "elasticsearch"
      }
      name = "elasticsearch"
    }
    spec = {
      ports = [
        {
          name = "http"
          port = 9200
          protocol = "TCP"
          targetPort = 9200
        },
      ]
      selector = {
        app = "elasticsearch"
      }
      type = "ClusterIP"
    }
  }
}