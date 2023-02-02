```yaml
# eksctl create cluster
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: my-cluster
  region: us-east-1
  version: "1.21"
availabilityZones:
- us-east-1a
- us-east-1b
managedNodeGroups:
- name: general
  labels:
    role: general
  instanceType: t3.small
  desiredCapacity: 2
  minSize: 1
  maxSize: 10
  volumeSize: 20
```

More:
https://www.linkedin.com/pulse/eks-cluster-using-terraform-shishir-khandelwal/
https://github.com/shishirkh/kubernetes-cluster-terraform-aws