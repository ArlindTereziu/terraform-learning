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
  #   backend "azurerm" {
  #     resource_group_name  = "rg-tfstate"
  #     storage_account_name = "attfstatefile"
  #     container_name       = "tfstatefiles"
  #     key                  = "tfgitaction.tfstate"
  #   }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-test-01"
  location = "westeurope"
}