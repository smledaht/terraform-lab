variable "container_registry_name" {
  description = "Container Registry name"
  type        = any
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = any
}

variable "location" {
  description = "Location in which to deploy the network"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}
