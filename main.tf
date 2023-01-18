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
    source = "terraform"
    project = "lab"
  }
}