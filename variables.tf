variable "project_name" {
  default = "untitlled"
}

variable "env" {
  default = "test"

variable "ec2_key" {
  default = "sandbox-key"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "public1_cidr" {
  default = "10.1.10.0/24"
}

variable "public2_cidr" {
  default = "10.1.11.0/24"
}

variable "private1_cidr" {
  default = "10.1.21.0/24"
}

variable "private2_cidr" {
  default = "10.1.22.0/24"
}
