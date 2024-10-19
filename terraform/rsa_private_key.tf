# Generate an RSA private key
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an EC2 Key Pair in AWS with the generated public key
resource "aws_key_pair" "UbuntuKP" {
  key_name   = "mykey" # Name of the key pair in AWS
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = <<EOF
    echo '${tls_private_key.pk.private_key_pem}' > /home/vm/worker-agent/Depi-Final-Project/terraform/mykey.pem
    chmod 400 /home/vm/worker-agent/Depi-Final-Project/terraform/mykey.pem
    EOF
  }
}
