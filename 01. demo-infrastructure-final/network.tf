resource "azurerm_virtual_network" "vnet" {
  name                = "dev-vnet-devops-tf-${var.name_sufix}"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "dev-subnet-devops-tf-${var.name_sufix}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_security_group" "nsg" {
  name                = "dev-nsg-devops-tf-${var.name_sufix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.allowed_ports
    content {
      name                       = "allow-port-${security_rule.value}"
      priority                   = 100 + index(var.allowed_ports, security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
resource "azurerm_network_interface" "nic" {
  name                = "dev-nic-devops-tf-${var.name_sufix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dev-ipc-devops-tf-${var.name_sufix}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "dev-pip-devops-tf-${var.name_sufix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "uax-devops"
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}