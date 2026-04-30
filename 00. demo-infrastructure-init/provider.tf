terraform {
  required_version = ">=1.11"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
   subscription_id = "33b67b58-295c-435c-8a86-9aaffe6fa0d5"
   resource_provider_registrations = "none"
   features {}
}
