variable "resource_group_name" {
  description = "Resource Group name"
  type        = any
}

variable "location" {
  description = "Location in which to deploy the network"
  type        = string
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "address_prefixes" {
  description = "Subnet address prefix"
  type        = list(string)
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}
