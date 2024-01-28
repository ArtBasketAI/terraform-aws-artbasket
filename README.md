# Terraform AWS ArtBasket Infrastructure

This repository contains the Terraform modules for deploying and managing the ArtBasket infrastructure on AWS.

## Structure

- `/modules` - Contains reusable Terraform modules for ECS, VPC, Security Groups, etc.
- `/environments` - Contains environment-specific configurations (e.g., development, staging, production).

## Getting Started

### Prerequisites

- Install [Terraform](https://www.terraform.io/downloads.html).
- Configure your AWS credentials.

### Deployment

To deploy an environment (e.g., development):

1. **Navigate to the environment's directory:**
   ```sh
   cd environments/dev
    ```

2. Initialize Terraform:

    ```sh
    terraform init
    ```

3. Apply the Terraform plan:

    ```sh
    terraform apply
    ```
