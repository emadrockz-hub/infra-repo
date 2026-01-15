variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "three-container-app"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR (set this! e.g. 1.2.3.4/32). Default is open to the world."
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Existing AWS EC2 Key Pair name (used for SSH). Create/import one in EC2 console."
  type        = string
}
