# Usage
For local Kubernetes cluster (Kind) due to having no LoadBalancer implementation, we have to port-forward the ingress controller to mock the traffic for ingress rule
```sh
    k port-forward --address 0.0.0.0 svc/ingress-nginx-controller -n ingress-nginx 80
    k port-forward --address 0.0.0.0 svc/ingress-nginx-controller -n ingress-nginx 443
```