# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "attfstatefile"
    container_name       = "tfstatefiles"
    key                  = "tfgitaction.tfstate"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-test"
  location = "westeurope"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-lan"
  address_space       = ["10.0.17.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
}