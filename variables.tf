variable "project_name" {
  type        = string
  default     = "three-container-app"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "my_ip_cidr" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  type = string
}
