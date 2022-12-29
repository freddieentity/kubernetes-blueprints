kubectl patch cm/argocd-cm --patch-file ldap/dex-connector.yaml
kubectl patch cm/argocd-cm --patch-file ldap/dex-connector.yaml

kubectl -n argocd patch secrets argocd-secret --patch "{\"data\":{\"dex.ldap.bindPW\":\"$(echo XXPASWDXXXXX | base64 -w 0)\"}}"


kubectl delete po -l app.kubernetes.io/component=server  -n argocd
kubectl delete po -l app.kubernetes.io/component=dex-server  -n argocd