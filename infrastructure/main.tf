# Configure providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Core resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Data Lake (Gen2)
module "data_lake" {
  source              = "./modules/data_lake"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  storage_account_name = "retaildl${random_string.suffix.result}"
  containers          = ["raw", "processed", "forecasts"]
}

# Machine Learning Workspace
module "ml_workspace" {
  source              = "./modules/ml_workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  workspace_name      = "retail-forecast-ml"
  sku                 = "Enterprise"
}
