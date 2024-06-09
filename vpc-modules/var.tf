variable "vpccidr" {
description = "List of cidr for the different vpc, this would determine the number of vpcs that would be created "   
type = string
}

variable "project" {
  description = "name of the project"
  type = string
}

variable "Environment" {
  description = "Environment name  could be either prod , Dev"
  type = string
}

variable "az1" {
  description = "Availability zone 1"
  type = string
}

variable "az2" {
  description = "Availability zone 2"
  type = string
}

variable "priv1cidr" {
  description = "cidr for priv 1 subnet"
  type = string
}

variable "priv2cidr" {
  description = "cidr for priv2 subnet"
  type = string 
}