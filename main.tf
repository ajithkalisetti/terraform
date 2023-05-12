terraform {
  required_version = ">=0.12"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
    }
  }
}

provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "rg" {
  
  name = var.resource_group_name
  location = var.resource_group_location
  
}

resource "azurerm_virtual_network" "vnet" {

    name = var.vnet_name
    location = var.vnet_location
    address_space = ["10.0.0.0/16"]
    subnet = ["10.0.1.0/24"]
    resource_group_name = azurerm_resource_group.rg.name
  
}
