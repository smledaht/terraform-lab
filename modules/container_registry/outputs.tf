output name {
  description = "Specifies the name of the container registry"
  value       = azurerm_container_registry.cr.name
}

output container_registry_id {
  description = "Specifies the resource id of the container registry"
  value       = azurerm_container_registry.cr.id
}
