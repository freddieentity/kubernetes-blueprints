
```kubectl get secrets/argocd-initial-admin-secret --template={{.data.password}} | base64 -D```