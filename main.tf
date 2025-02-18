provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "rg_ai" {
  name     = "rg-ai-resources"
  location = "East US"
}

# Create a Storage Account (required for AI/ML logging and data)
resource "azurerm_storage_account" "storage_ai" {
  name                     = "aistorageacct"
  resource_group_name      = azurerm_resource_group.rg_ai.name
  location                 = azurerm_resource_group.rg_ai.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create an Azure Machine Learning Workspace
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                = "aml-workspace"
  resource_group_name = azurerm_resource_group.rg_ai.name
  location            = azurerm_resource_group.rg_ai.location
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }

  storage_account_id = azurerm_storage_account.storage_ai.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg_ai.name
}

output "ml_workspace_name" {
  value = azurerm_machine_learning_workspace.ml_workspace.name
}
