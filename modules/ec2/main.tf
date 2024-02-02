# modules/ec2/main.tf

resource "aws_instance" "app_server" {
  count                     = var.instance_count
  ami                       = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id
  key_name                  = var.key_name
  security_groups           = [var.sg_id]
  iam_instance_profile      = aws_iam_instance_profile.ecr_access_profile.name

  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                # Update the installed packages and package cache
                yum update -y
                # Install Docker
                yum install -y docker
                # Start the Docker service
                service docker start
                # Ensure Docker starts on reboot
                chkconfig docker on
                # Authenticate Docker to your default ECR registry
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 032279951720.dkr.ecr.us-east-1.amazonaws.com
                # Pull the Docker image from ECR
                docker pull 032279951720.dkr.ecr.us-east-1.amazonaws.com/ab-frontend-img:latest
                # Run the Docker container, replace <options> with your Docker run options
                docker run --platform linux/amd64 -d -p 3000:3000 032279951720.dkr.ecr.us-east-1.amazonaws.com/ab-frontend-img:latest
                EOF

  tags = {
    Name = "app-server-${count.index}"
  }
}

resource "aws_lb_target_group_attachment" "tga" {
  count            = var.instance_count
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app_server.*.id[count.index]
  port             = 3000
}

resource "aws_iam_instance_profile" "ecr_access_profile" {
  name = "ecrAccessProfile"
  role = aws_iam_role.ec2_role.name
}