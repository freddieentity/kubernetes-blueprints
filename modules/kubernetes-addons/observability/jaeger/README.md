
kubectl create namespace observability

kubectl --namespace observability apply \
    --filename https://github.com/jaegertracing/jaeger-operator/releases/download/v1.39.0/jaeger-operator.yaml