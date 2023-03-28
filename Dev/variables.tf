variable "location" {
  description = "Azure region"
  type        = string
  default     = "CentralUS"
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default = {
    createdWith = "Terraform"
  }
}

## Naming conventions
variable "loc" {
  type        = string
  default     = "cus" 
}
variable "org" {
  type        = string
  default     = "ppi"
}
variable "env" {
  type        = string
  default     = "ppd"
}

variable "resgrp" {
    type = map(any)
}

variable "subnets" {
  type = map(any)
}

variable "vnets" {
  type = map(any)
}

variable "containerregistries" {
  type = map(any)
}

# variable "containerapps" {
#   type = map(any)
# }

