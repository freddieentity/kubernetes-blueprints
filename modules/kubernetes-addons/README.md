k apply -f cert-manager-1.10.0.yaml
k apply -f selfsigned

helm install ingress-nginx nginx-stable/nginx-ingress --create-namespace=true -n ingress-controller