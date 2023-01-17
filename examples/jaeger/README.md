```sh
kubectl create namespace observability
# Require Cert manager & Nginx ingress controller
kubectl --namespace observability apply \
    --filename https://github.com/jaegertracing/jaeger-operator/releases/download/v1.39.0/jaeger-operator.yaml
```

```sh
echo "
apiVersion: jaegertracing.io/v1
kind: Jaeger
metadata:
  name: jaeger
spec:
  ingress:
    enabled: true
    ingressClassName: nginx
    hosts:
      - jaeger.$INGRESS_HOST.nip.io
" | kubectl --namespace observability apply --filename -
```