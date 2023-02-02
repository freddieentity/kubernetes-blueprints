# Checklist
In order to use the Terraform the decent way. We should seperate the lifecycle of provisioning resources for Terraform goverance including
* Terraform storage to manage state files centrally
* Temporary credentials (Azure AD Service Principals, AWS STS Token, Vault Dynamic Secrets)

[Should]
Seperate Terraform manifests into compositions:
- Launchpad: AD instance and objects, identites (Azure subscriptions, AWS Account), AWS Control Tower, AWS Organization
- Security & Compliance: guardrail policies, RBAC
- Networking (Hub & Spokes): backups, DR plans
- Application infra (Landing zone): Deploy into spokes. Create PaaS (AKS, FW, AppGW, ACR, KV)
- Application: Deploy workloads

## Create the storage for the Terraform state
```sh
#!/bin/sh
 
RESOURCE_GROUP_NAME="tamopsterraform-rg"
STORAGE_ACCOUNT_NAME="tamopsterraform"
 
# Create Resource Group
az group create -l uksouth -n $RESOURCE_GROUP_NAME
 
# Create Storage Account
az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l uksouth --sku Standard_LRS
 
# Create Storage Account blob
az storage container create  --name tfstate --account-name $STORAGE_ACCOUNT_NAME
```