# Makefile for managing Terraform deployments

# Prevents Make from treating target names as filenames
.PHONY: init plan apply destroy validate fmt output

# Directory of your Terraform environment (change as needed)
ENV_DIR := environments/dev

# Initialize Terraform
# This command initializes a Terraform working directory, installs modules, etc.
init:
	@cd $(ENV_DIR) && terraform init

# Plan Infrastructure Changes
# This command creates an execution plan, showing what actions Terraform will perform.
plan:
	@cd $(ENV_DIR) && terraform plan

# Apply Infrastructure Changes
# This command applies the changes required to reach the desired state of the configuration.
apply:
	@cd $(ENV_DIR) && terraform apply

# Destroy Infrastructure
# This command destroys the Terraform-managed infrastructure.
destroy:
	@cd $(ENV_DIR) && terraform destroy

# Validate Configuration
# This command checks if the configuration is syntactically valid and internally consistent.
validate:
	@cd $(ENV_DIR) && terraform validate

# Format Configuration
# This command automatically updates configurations in the standard format.
fmt:
	@cd $(ENV_DIR) && terraform fmt

# Show Output Values
# This command outputs any values defined in your Terraform configuration.
output:
	@cd $(ENV_DIR) && terraform output
