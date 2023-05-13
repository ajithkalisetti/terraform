terraform {
  required_version = ">=0.12"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
    }
  }
}
# Configure the Azure provider
provider "azurerm" {
    features {}
  
}
# Create an azure resource group

resource "azurerm_resource_group" "rg" {
  
  name = var.resource_group_name
  location = var.resource_group_location
  
}
# Create a Virtual Network

resource "azurerm_virtual_network" "vnet" {

    name = var.vnet_name
    location = var.vnet_location
    address_space = ["193.0.0.0/16"]
    resource_group_name = azurerm_resource_group.rg.name
  
}
# Create a Subnet in the above Virtual Network
resource "azurerm_subnet" "Subnet1" {
   
   name = var.subnet_name
   address_prefixes = ["193.0.1.0/24"]
   resource_group_name = azurerm_resource_group.rg
   virtual_network_name = azurerm_virtual_network.vnet
}
# Create a Public IP for VM
resource "azurerm_public_ip" "Public IP" {
  name = "${var.vm_name}-IP"
  allocation_method = "Dynamic"
  location = var.vnet_location
  resource_group_name = azurerm_resource_group.rg
}
# Create a NIC for VM
resource "azurerm_network_interface" "Network Interface" {
  name = "${var.vm_name}-NIC"
  resource_group_name = azurerm_resource_group.rg
  location = var.vnet_location
}
