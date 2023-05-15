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

variable "vm_location" {
  type        = string
  description = "Location of the VM"
}

variable "vm_name" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "subnet_name" {
  type        = string
  description = "Name of the SubNet"
}
variable "vm_size" {
  type        = string
  description = "Specify size of the VM (EX: B2s/B2ms/B4ms)"
}
variable "public_key" {
  type        = string
  description = "Specify your public key"
}
variable "hostname" {
  type        = string
  description = "specify hostname for the vm"
}
variable "admin_username" {
  type        = string
  description = "Specify username to login"
}
variable "admin_password" {
  type        = string
  sensitive = true
  description = "Specify login password for the user "
}
