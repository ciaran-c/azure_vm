terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
#      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

#provider "azurerm" {
#  features {}
#}

data "azurerm_subnet" "azurerm_subnet" {
  name                 = var.subnet
  resource_group_name  = var.rg
  virtual_network_name = var.vnet
}

resource "azurerm_network_interface" "azurerm_nic" {
  name                = "NIC-${var.vm_name}-TEST-NE"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.azurerm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#data "azurerm_shared_image" "shared_image" {
#  name                = var.shared_image_name
#  gallery_name        = var.gallery_name
#  resource_group_name = var.rg
#}

resource "azurerm_linux_virtual_machine" "azurerm_vm" {
#  delete_os_disk_on_termination = true
#  delete_data_disks_on_termination = true

  disable_password_authentication = false

  name                = var.vm_name
  location            = var.location
  size                = "Standard_DS1_v2"
  resource_group_name = var.rg
  admin_username      = var.vdi_user
  admin_password      = var.vdi_password
  network_interface_ids = [
    azurerm_network_interface.azurerm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

