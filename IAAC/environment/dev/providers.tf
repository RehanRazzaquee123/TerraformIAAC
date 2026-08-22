terraform {
  backend "azurerm" {
    resource_group_name  = "mera-rg"
    storage_account_name = "storageb18"
    container_name       = "augcontainer"
    key                  = "dev/pipeline.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ee2ae788-9582-4219-9666-16d19b8ebd6e"
}