provider "azurerm" {
  features {}
}


locals {
  inventory = jsondecode(file("${path.module}/inventory.json"))
}


module "azurerm_virtual_machine" {
  for_each     = { for idx, v in local.inventory : v.name => v }
  source       = "./modules/azurerm_virtual_machine/"
  vm_name      = each.value.name
  rg           = "Service-Catalog-RG"
  vdi_user     = "adminuser"
  vdi_password = "AzureRulz00!"
  vnet         = "Service-Catalog-VNET"
  subnet       = each.value.subnet
}

