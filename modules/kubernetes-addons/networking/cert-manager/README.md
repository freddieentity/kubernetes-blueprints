# Cert Manger
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.10.0 \
    --create-namespace \
    --values cert-manager-values.yaml
    --set installCRDs=true


k apply -f cert-manager-1.10.0.yaml
k create ns cert-manager-test
k apply -f .selfsigned


helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.10.0 \
    --create-namespace \
    --values cert-manager-values.yaml