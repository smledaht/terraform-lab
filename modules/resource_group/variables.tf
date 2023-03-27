variable "resource_group" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Location in which to deploy the network"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}
