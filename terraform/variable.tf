variable "Environment" {
  description = "The environment for the resources"
  type        = string
  default     = "DEPI"
}

variable "Owner" {
  description = "The owner of the resources"
  type        = string
  default     = "Ibrahim Aamer"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_type" {
  description = "The name for the instance type"
  type        = string
}

variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
}
