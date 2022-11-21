from diagrams import Cluster, Diagram, Group
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.vcs import Gitlab
from diagrams.onprem.monitoring import Grafana, Prometheus, Thanos
from diagrams.onprem.logging import FluentBit
from diagrams.onprem.tracing import Jaeger
from diagrams.onprem.ci import Jenkins
from diagrams.saas.chat import Slack, Teams
from diagrams.elastic.elasticsearch import Kibana, Elasticsearch
from diagrams.k8s.ecosystem import Helm
from diagrams.onprem.gitops import ArgoCD
from diagrams.onprem.iac import Ansible, Terraform
from diagrams.onprem.security import Trivy, Vault
from diagrams.onprem.certificates import CertManager
from diagrams.custom import Custom

with Diagram("GitOps End to End", show=False):
    
    
    # slack = Slack("Slack")
    # teams = Teams("Teams")
    
    # trivy = Trivy("Trivy")
    

    with Group("Manifests Repository"):
        helm = Helm("Helm")

    with Group("CI System"):
        jenkins = Jenkins("Jenkins")

    with Group("IaC Repository"):
        terraform = Terraform("Terraform")
        with Group("Servers"):
            jenkins = Jenkins("Jenkins")
            vault = Vault("Vault")
            ansible = Ansible("Ansible")
            gitlab = Gitlab("Gitlab")
            postgreSQL = PostgreSQL("PostgreSQL")
            nexus = Custom("Nexus", "https://assets-global.website-files.com/5f10ed4c0ebf7221fb5661a5/5f2af61146c55b6e172fa5b3_NexusRepo_Icon.png")
            sonarqube = Custom("Sonarqube", "https://www.svgrepo.com/show/306758/sonarqube.svg")

        
        with Group("Kubernetes toolchain"):
            argoCD = ArgoCD("ArgoCD")
            fluentBit = FluentBit("FluentBit")
            prometheus = Prometheus("Prometheus")
            grafana = Grafana("Grafana")
            thanos = Thanos("Thanos")
            jaeger = Jaeger("Jaeger")
            kibana = Kibana("Kibana")
            elasticsearch = Elasticsearch("Elasticsearch")
            certManager = CertManager("CertManager")
            