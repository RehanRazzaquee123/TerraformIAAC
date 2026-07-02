terraform {
  backend "azurerm" {
    resource_group_name  = "PrabhGit"
    storage_account_name = "storageaccprabh"
    container_name       = "teraformpipeline"
    key                  = "pipeline.tfstate"
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
  subscription_id = "3e435172-5e9c-4c87-9f88-72d810198f70"
}