resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "dev-vm-devops-tf-${var.name_sufix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  size               = var.vm_size
  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = -1
  disable_password_authentication = false
  admin_username = "azureuser"
  admin_password = "@zur3us3r"
  network_interface_ids = [azurerm_network_interface.nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name              = "dev-dk-devops-tf-${var.name_sufix}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}