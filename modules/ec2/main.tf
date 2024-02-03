# modules/ec2/main.tf

resource "aws_instance" "app_server" {
  count                = var.instance_count
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  key_name             = var.key_name
  security_groups      = [var.sg_id]
  iam_instance_profile = aws_iam_instance_profile.new_ecr_access_profile.name

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
              # Install Docker Compose
              curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              # Authenticate Docker to your default ECR registry
              $(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 032279951720.dkr.ecr.us-east-1.amazonaws.com)
              # Create the docker-compose.yml file
              cat > /home/ec2-user/docker-compose.yml <<'EOC'
              version: '3'
              services:
                backend:
                  image: 032279951720.dkr.ecr.us-east-1.amazonaws.com/ab-backend-img:latest
                  ports:
                    - "8080:8080"
                frontend:
                  image: 032279951720.dkr.ecr.us-east-1.amazonaws.com/ab-frontend-img:latest
                  ports:
                    - "3000:3000"
                  depends_on:
                    - backend
              EOC
              # Navigate to the directory containing docker-compose.yml
              cd /home/ec2-user
              # Start up the application stack
              docker-compose up -d
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

resource "aws_iam_instance_profile" "new_ecr_access_profile" {
  name = "new_ecr_access_profile"
  role = var.ecr_access_role_name
}
