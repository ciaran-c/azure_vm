provider "azurerm" {
  features {}
}


locals {
  inventory = jsondecode(file("${path.module}/inventory.json"))
}


output "inventory" {
  value = local.inventory
}


module "azurerm_virtual_machine" {
  for_each     = { for idx, v in local.inventory.virtual_machine : v.name => v }
  source       = "./modules/azurerm_virtual_machine/"
  vm_name      = each.value.name
  rg           = "RG-DAASVDI-SB-DAASVDI-TEST-NE-001"
  vdi_user     = "adminuser"
  vdi_password = "AzureRulz00!"
  vnet         = "VNET-DAASVDI-SB-DAASVDI-TEST-NE-001"
  subnet       = each.value.subnet
}

