# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  cloud {
    organization = "arlindtereziu"

    workspaces {
      name = "gh-actions"
    }
  }
  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-networking" {
  name     = "rg-networking"
  location = "West Europe"
  tags = {
    environment = "production"
    source      = "terraform"
    project     = "lab"
  }
}
resource "azurerm_network_security_group" "nsg-networking" {
  name                = "nsg-networking"
  location            = azurerm_resource_group.rg-networking.location
  resource_group_name = azurerm_resource_group.rg-networking.name
  tags = {
    environment = "production"
    source      = "terraform"
    project     = "lab"
  }
}

resource "azurerm_virtual_network" "vnet-lan" {
  name                = "vnet-lan"
  location            = azurerm_resource_group.rg-networking.location
  resource_group_name = azurerm_resource_group.rg-networking.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsg-networking.id
  }

  tags = {
    environment = "production"
    source      = "terraform"
    project     = "lab"
  }
}
module "vnet-test" {
  source  = "Azure/vnet/azurerm"
  version = "4.0.0"
  # insert the 3 required variables here
  resource_group_name = azurerm_resource_group.rg-networking.name
  vnet_location = azurerm_resource_group.rg-networking.location
  use_for_each = true
}