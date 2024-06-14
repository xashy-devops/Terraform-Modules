#Region
variable "region" {
  description = "Region of deployment."
  type = string
}

#vpc cidr
variable "vpc_cidr" {
  description = "cidr block of vpc."
  type = string
}

#Subnet cidr blocks
variable "subnet_cidr" {
  description = "Cidr blocks of subnets"
  type = list(string)
}

#Subnet availability zones
variable "subnet_AZs" {
  description = "Availability zones for subnet provisioning"
  type = list(string)
}