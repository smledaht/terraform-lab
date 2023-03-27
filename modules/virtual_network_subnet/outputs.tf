output name {
  description = "Specifies the name of the subnet network"
  value       = azurerm_subnet.subnet.name
}

output subnet_id {
  description = "Specifies the resource id of the subnet network"
  value       = azurerm_subnet.subnet.id
}

output subnet_prefixes {
 description = "Contains a list of the the resource id of the subnets"
  value       = azurerm_subnet.subnet.address_prefixes
}