resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "main_vpc"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 0)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-public-1"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
