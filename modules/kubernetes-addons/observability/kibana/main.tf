resource "kubernetes_manifest" "deployment_logging_kibana" {
  manifest = {
    apiVersion = "apps/v1"
    kind = "Deployment"
    metadata = {
      labels = {
        app = "kibana"
      }
      name = "kibana"
      namespace = "logging"
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app = "kibana"
        }
      }
      template = {
        metadata = {
          labels = {
            app = "kibana"
          }
        }
        spec = {
          containers = [
            {
              env = [
                {
                  name = "ELASTICSEARCH_URL"
                  value = "http://elasticsearch:9200"
                },
                {
                  name = "ELASTICSEARCH_HOSTS"
                  value = "http://elasticsearch:9200"
                },
              ]
              image = "kibana:7.9.1"
              imagePullPolicy = "IfNotPresent"
              name = "kibana"
              ports = [
                {
                  containerPort = 5601
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_kibana" {
  manifest = {
    apiVersion = "v1"
    kind = "Service"
    metadata = {
      labels = {
        app = "kibana"
      }
      name = "kibana"
    }
    spec = {
      ports = [
        {
          name = "http"
          port = 5601
          protocol = "TCP"
          targetPort = 5601
        },
      ]
      selector = {
        app = "kibana"
      }
      type = "ClusterIP"
    }
  }
}