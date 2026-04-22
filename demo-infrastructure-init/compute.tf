resource "azurerm_network_interface" "nic" {
  name                = "dev-nic-devop-stf-train"
  location                 = var.location
  resource_group_name      = var.resource_group_name

  ip_configuration {
    name                          = "dev-ipc-devops-tf-train"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "dev-pip-devops-tf-train"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "uax-devops"
}

resource "azurerm_storage_account" "stor" {
  name                     = "devstdevopstftrain"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "dev-vm-devops-tf-train"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "dev-dk-devops-tf-train"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
    admin_password = "Azur3Us3r"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.stor.primary_blob_endpoint
  }
}
