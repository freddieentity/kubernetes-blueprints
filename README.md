# IaC for Kubernetes addons, AWS resources and configuration

## High-level Architectural Diagram
![High-level architectural diagram](docs/images/high-level-architecture.png)

## Code Structure

* Terragrunt folder holds the environment configurations and generate environment specific config base on the .hcl files. .hcl in each environment section will pass its own values to the root .hcl file
* Modules folder holds all the Terraform modules
* Examples folder holds different the usages of the module in the repository