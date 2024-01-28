# modules/ec2/main.tf

resource "aws_instance" "app_server" {
  count           = var.instance_count
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = var.key_name
  security_groups = [var.sg_id]

  user_data = <<-EOF
                  #!/bin/bash
                  sudo apt-get update
                  sudo apt-get install -y docker.io
                  sudo systemctl start docker
                  sudo systemctl enable docker
                  sudo docker run -d -p 3000:3000 bharathts07/artbasket-frontend
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
