output name {
  description = "Specifies the name of the virtual network"
  value       = azurerm_resource_group.rg.name
}

output rg_id {
  description = "Specifies the resource id of the subnet network"
  value       = azurerm_resource_group.rg.id
}