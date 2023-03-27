terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.49.0"
    }
  }
  #  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

module "resource_group_network" {
  for_each       = var.vnets
  source         = "../modules/resource_group"
  resource_group = "${each.value["vnet_name"]}-rg"
  location       = var.location
  tags           = var.tags
}

#################### The above resouce group names are based on the virtual network
#################### We can determine a common value around the resouces to based the name on 
# module "resource_group_??????????" {
#   for_each       = var.vnets
#   source         = "../modules/resource_group"
#   resource_group = "${each.value["vnet_name"]}-rg"
#   location       = var.location
#   tags           = var.tags
# }

module "virtual_network" {
  for_each            = var.vnets
  source              = "../modules/virtual_network"
  resource_group_name = module.resource_group_network[each.value["vnet_name"]].name
  vnet_name           = each.value["vnet_name"]
  location            = var.location
  address_space       = each.value["address_space"]
  tags                = var.tags
}

module "virtual_network_subnet" {
  for_each            = var.subnets
  source              = "../modules/virtual_network_subnet"
  resource_group_name = module.resource_group_network[each.value["vnet_name"]].name
  vnet_name           = module.virtual_network[each.value["vnet_name"]].name
  subnet_name         = each.value["subnet_name"]
  address_prefixes    = each.value["address_prefixes"]
  location            = var.location
}

module "container_registry" {
  for_each                = var.containerregistries
  source                  = "../modules/container_registry"
  container_registry_name = each.value["cr_name"]
  resource_group_name     = module.resource_group_network["app"].name
  location                = var.location

}

############### Below needs to be converted to modules ########################
resource "azurerm_user_assigned_identity" "example" {
  location            = var.location
  name                = "example"
  resource_group_name = module.resource_group_network["app"].name
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_user_assigned_identity.example.principal_id
  role_definition_name             = "AcrPull"
  scope                            = module.container_registry["thadelmsdevcr"].container_registry_id
  skip_service_principal_aad_check = true
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "acctest-01"
  location            = var.location
  resource_group_name = module.resource_group_network["app"].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = var.location
  resource_group_name        = module.resource_group_network["app"].name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

resource "azurerm_container_app" "example" {
  name                         = "example-app"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = module.resource_group_network["app"].name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]

  }

  registry {
    server = "thadelmsdevcr.azurecr.io"
    identity = azurerm_user_assigned_identity.example.id
  }
}