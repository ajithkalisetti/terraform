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
    location = var.vm_location
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
resource "azurerm_public_ip" "Public_IP" {
  name = "${var.vm_name}-IP"
  allocation_method = "Dynamic"
  location = var.vm_location
  resource_group_name = azurerm_resource_group.rg
}
# Create a NIC for VM
resource "azurerm_network_interface" "Network_Interface" {
  name = "${var.vm_name}-NIC"
  resource_group_name = azurerm_resource_group.rg
  location = var.vm_location
  ip_configuration {
    name = "${var.vm_name}-IPConfiguration"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.Public_IP
    subnet_id = azurerm_subnet.Subnet1
  }
}
# Create Virtual Machine
resource "azurerm_virtual_machine" "vm" {
    name = var.vm_name
    location = var.vm_location
    resource_group_name = azurerm_resource_group.rg
    network_interface_ids = azurerm_network_interface.Network_Interface
    vm_size = var.vm_size
    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"
    }
    storage_os_disk {
      name = "${var.vm_name}-os-disk"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile {
      computer_name = var.hostname
      admin_username = var.admin_username
      admin_password = var.admin_password
    }
    os_profile_linux_config {
      disable_password_authentication = false
      ssh_keys {
        path =  "/home/${var.admin_username}/.ssh/authorized_keys"
        key_data = var.public_key
      }
    }
  
