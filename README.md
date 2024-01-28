# Terraform AWS Infrastructure for ArtBasket

This Terraform project sets up the AWS infrastructure for the ArtBasket application, which includes VPC, EC2 instances, an Application Load Balancer, and Route 53 configurations.

## Structure

The project is structured as follows:

- `main.tf`: Main configuration file that sets up the AWS provider and defines modules.
- `variables.tf`: Defines variables used across the configuration.
- `outputs.tf`: Defines outputs from the Terraform configuration.
- `s3.tf`: Configuration for the S3 bucket.
- `modules/`: Contains sub-modules for each part of the infrastructure.

## Modules

- `vpc`: Sets up the VPC, subnets, and internet gateway.
- `security_group`: Configures security groups for EC2 and ALB.
- `ec2`: Defines the EC2 instances setup, including Docker and the Node.js application.
- `alb`: Configures the Application Load Balancer.
- `route53`: Sets up DNS records in Route 53.

## Usage

1. Initialize the Terraform environment:

    ```bash
    terraform init
    ```

2. Review the Terraform plan:

    ```bash
    terraform plan
    ```

3. Apply the Terraform configuration:

    ```bash
    terraform apply
    ```

## Cleanup and Removal of Provisioned Resources

To safely remove and clean up all resources provisioned by Terraform in your AWS environment, follow these steps:

1. **Terraform Destroy**: Run the `terraform destroy` command. This command will prompt you to review and confirm the resources that Terraform will delete.

   ```bash
   terraform destroy
   ```

## Notes

- Before running `terraform apply`, ensure your AWS credentials are set up correctly.
- Update the `terraform.tfvars` file with specific values for your deployment.
- For SSH access to the EC2 instances, update the key file path in `main.tf`.
- Review and update the AMI IDs in `variables.tf` to match your region and requirements.
