# =========== #
#  Interface  #
# =========== #

BLACK        := $(shell tput -Txterm setab 0 && tput -Txterm setaf 7)
RED          := $(shell tput -Txterm setab 1 && tput -Txterm setaf 0)
GREEN        := $(shell tput -Txterm setab 2 && tput -Txterm setaf 0)
YELLOW       := $(shell tput -Txterm setab 3 && tput -Txterm setaf 0)
LIGHTPURPLE  := $(shell tput -Txterm setab 4 && tput -Txterm setaf 0)
PURPLE       := $(shell tput -Txterm setab 5 && tput -Txterm setaf 7)
BLUE         := $(shell tput -Txterm setab 4 && tput -Txterm setaf 0)
WHITE        := $(shell tput -Txterm setab 7 && tput -Txterm setaf 0)
RESET        := $(shell tput -Txterm sgr0)
BLUE_TEXT    := $(shell tput -Txterm setaf 4)
RED_TEXT     := $(shell tput -Txterm setaf 1)
YELLOW_TEXT  := $(shell tput -Txterm setaf 3)

# ================== #
#  Environment Vars  #
# ================== #

ENV?=dev

# ========= #
#  Scripts  #
# ========= #

init:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${PURPLE} Terraform ${RESET} Init\n"
	terraform init -backend-config=environments/${ENV}/${ENV}.backend.hcl

plan:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${PURPLE} Terraform ${RESET} Plan\n"
	terraform plan -var-file=environments/${ENV}/${ENV}.tfvars

apply:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${BLUE} Terraform ${GREEN} Apply ${RESET}\n"
	terraform apply -var-file=environments/${ENV}/${ENV}.tfvars -auto-approve

destroy:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${BLUE} Terraform ${RED} Destroy ${RESET}\n"
	terraform destroy -var-file=environments/${ENV}/${ENV}.tfvars -auto-approve

up:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${PURPLE} Terraform ${RESET} Apply\n"
	terraform apply -auto-approve
down:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${RED} Terraform ${RESET} Destroy\n"
	terraform destroy -auto-approve

echo:
	@echo "\n${GREEN} Environment($(ENV))${RESET} | ${BLUE} Terraform ${GREEN} Apply ${RESET}\n"
	@echo "${BLUE} Terraform ${RED} Destroy ${RESET}"