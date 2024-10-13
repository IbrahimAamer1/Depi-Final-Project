resource "aws_instance" "ubuntu-instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_public_1.id
  key_name               = aws_key_pair.UbuntuKP.key_name
  vpc_security_group_ids = [aws_security_group.UbuntuSG.id]

  # Enable public IP assignment
  associate_public_ip_address = true

  # Add shell script to install Docker and Git
  user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                    sudo apt-get update
                    sudo apt-get install -y docker-ce

                    # Install Git 
                    sudo apt-get install -y git

                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo groupadd docker
                    sudo usermod -aG docker $USER && newgrp docker
                    sudo chmod 666 /var/run/docker.sock
                    
                    # Install Docker compose
                    sudo apt-get install -y docker-compose

                  EOF

  tags = {
    Name        = "Python-App-Server"
    Environment = var.Environment
    Owner       = var.Owner
  }

  # Ensure the instance is created after the key pair
  depends_on = [aws_key_pair.UbuntuKP]
}
