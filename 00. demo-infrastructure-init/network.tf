resource "azurerm_virtual_network" "vnet" {
  name                = "dev-vnet-devops-tf-trainer"
  address_space       = ["10.0.0.0/16"]
  location                 = var.location
  resource_group_name      = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "dev-subnet-devops-tf-trainer"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name      = var.resource_group_name
  address_prefixes     = ["10.0.1.0/24"]
}
