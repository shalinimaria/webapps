terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  resource_group = "app-grp"
  location       = "eastus"
}

resource "azurerm_resource_group" "app_grp" {
  name     = local.resource_group
  location = local.location
}

resource "azurerm_app_service_plan" "app_plan10" {
  name                = "app_plan10"
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "random_string" "unique_id" {
  length  = 8
  special = false
}

resource "azurerm_app_service" "app_svc" {
  name                = "appservice2-${random_string.unique_id.result}"
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  app_service_plan_id = azurerm_app_service_plan.app_plan10.id
}
