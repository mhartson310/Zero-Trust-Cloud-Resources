provider "azurerm" {
  features {}
}

# Create a Resource Group for all Zero Trust resources
resource "azurerm_resource_group" "rg_zero_trust" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Log Analytics Workspace for monitoring and diagnostics
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.rg_zero_trust.location
  resource_group_name = azurerm_resource_group.rg_zero_trust.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#############################
# Hub Virtual Network Setup #
#############################

# Hub VNet definition
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  address_space       = [var.hub_vnet_address_space]
  location            = azurerm_resource_group.rg_zero_trust.location
  resource_group_name = azurerm_resource_group.rg_zero_trust.name
}

# Hub Subnet
resource "azurerm_subnet" "hub_subnet" {
  name                 = var.hub_subnet_name
  resource_group_name  = azurerm_resource_group.rg_zero_trust.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.hub_subnet_address_prefix]
}

# NSG for Hub - restrict risky ports like RDP (3389) and SSH (22)
resource "azurerm_network_security_group" "nsg_hub" {
  name                = var.nsg_hub_name
  location            = azurerm_resource_group.rg_zero_trust.location
  resource_group_name = azurerm_resource_group.rg_zero_trust.name
}

resource "azurerm_network_security_rule" "nsg_hub_block_rdp" {
  name                        = "Block-RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_zero_trust.name
  network_security_group_name = azurerm_network_security_group.nsg_hub.name
}

resource "azurerm_network_security_rule" "nsg_hub_block_ssh" {
  name                        = "Block-SSH"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_zero_trust.name
  network_security_group_name = azurerm_network_security_group.nsg_hub.name
}

# Associate the NSG with the Hub subnet
resource "azurerm_subnet_network_security_group_association" "hub_subnet_assoc" {
  subnet_id                 = azurerm_subnet.hub_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_hub.id
}

###############################
# Spoke Virtual Network Setup #
###############################

# Spoke VNet definition
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = var.spoke_vnet_name
  address_space       = [var.spoke_vnet_address_space]
  location            = azurerm_resource_group.rg_zero_trust.location
  resource_group_name = azurerm_resource_group.rg_zero_trust.name
}

# Spoke Subnet
resource "azurerm_subnet" "spoke_subnet" {
  name                 = var.spoke_subnet_name
  resource_group_name  = azurerm_resource_group.rg_zero_trust.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = [var.spoke_subnet_address_prefix]
}

# NSG for Spoke - similar restrictions to the Hub
resource "azurerm_network_security_group" "nsg_spoke" {
  name                = var.nsg_spoke_name
  location            = azurerm_resource_group.rg_zero_trust.location
  resource_group_name = azurerm_resource_group.rg_zero_trust.name
}

resource "azurerm_network_security_rule" "nsg_spoke_block_rdp" {
  name                        = "Block-RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_zero_trust.name
  network_security_group_name = azurerm_network_security_group.nsg_spoke.name
}

resource "azurerm_network_security_rule" "nsg_spoke_block_ssh" {
  name                        = "Block-SSH"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_zero_trust.name
  network_security_group_name = azurerm_network_security_group.nsg_spoke.name
}

# Associate the NSG with the Spoke subnet
resource "azurerm_subnet_network_security_group_association" "spoke_subnet_assoc" {
  subnet_id                 = azurerm_subnet.spoke_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_spoke.id
}

####################################
# VNet Peering between Hub & Spoke #
####################################

# Peering from Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = azurerm_resource_group.rg_zero_trust.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
  allow_gateway_transit     = false
}

# Peering from Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = azurerm_resource_group.rg_zero_trust.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
  use_remote_gateways       = false
}
