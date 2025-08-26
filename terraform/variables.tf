variable "ami_id" {
  description = "AMI ID for EC2"
  default     = "ami-0f918f7e67a3323f0"   # <<< Replace with your AMI ID
}

variable "subnet_id" {
  description = "Default Subnet ID"
  default     = "subnet-083a8c50c53d0402d"  # <<< Replace with your Subnet ID
}    

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-0056d809452f9f8ea"  # <<< Replace with your VPC ID if required
}
