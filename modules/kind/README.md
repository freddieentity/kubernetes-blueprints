# Local Kubernetes Cluster for testing

Configure kind nodes
```yaml
# kind.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
 - role: control-plane
   image: kindest/node:v1.26.0
 - role: worker
   image: kindest/node:v1.26.0
 - role: worker
   image: kindest/node:v1.26.0
```

Work with cluster
```sh
# Create Kind clusters
kind create cluster --name=<your cluster name> --config=kind.yaml
# Destroy Kind cluster
kind destroy cluster --name=<your cluster name>
```