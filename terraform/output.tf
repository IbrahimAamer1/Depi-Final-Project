output "ubuntu-instance_id" {
  description = "The ID of the bastion host instance used for secure access to other resources."
  value       = aws_instance.ubuntu-instance.id
}

output "ubuntu-instance_public_ip" {
  description = "The public IP address of the bastion host, used for SSH access from external networks."
  value       = aws_instance.ubuntu-instance.public_ip
}

output "instance_public_dns" {
  value       = aws_instance.ubuntu-instance.public_dns
  description = "The public DNS of the bastion host"
}

# Create the inventory file in the main directory
resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOF
      echo "[app_servers]" > /home/vm/worker-agent/DEPI-Final-Project/inventory.ini
      echo "ec2-instance ansible_host=${aws_instance.ubuntu-instance.public_ip} \
      ansible_user=ubuntu \
      ansible_ssh_private_key_file=/home/vm/worker-agent/DEPI-Final-Project/terraform/mykey.pem \
      ansible_ssh_common_args='-o StrictHostKeyChecking=no' \

    EOF
  }
}

