variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNet"
}

variable "vnet_location" {
  type        = string
  description = "Location of the VNet"
}

variable "vm_name" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "subnet_name" {
  type        = string
  description = "Name of the SubNet"
}
