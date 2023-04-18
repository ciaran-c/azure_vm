variable "vm_name" {
  type = string
}

variable "location" {
  type    = string
  default = "northeurope"
  #description = "Azure region to create the resources in (e.g. northeurope)." 
}

variable "rg" {
  type = string
}

variable "vdi_user" {
  type = string
}

variable "vdi_password" {
  type = string
}

#variable "subscription_alias" {
#  type = string
#  #description = "Subscription alias for the spoke (e.g. SB-DAASVDI)." 
#}

variable "subnet" {
  type = string
}

variable "vnet" {
  type = string
}

#variable "shared_image_name" {
#  type = string
#}

#variable "gallery_name" {
#  type = string
#}

