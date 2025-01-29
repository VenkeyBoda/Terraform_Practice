# Create a resource group named "azure_modules" in the Central India region
resource "azurerm_resource_group" "base" {
  name     = "azure_modules"
  location = "centralindia"
}

# Module to create a virtual network (VNet)
module "vnet" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/vnet"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location

  # Information about the address space and the virtual network's name
  network_info = {
    address_space = ["10.0.0.0/16"]
    name          = "ntier"
  }

  # Subnet configuration
  subnets_info = [{
    name             = "web"
    address_prefixes = "10.0.0.0/24"
    }, {
    name             = "app"
    address_prefixes = "10.0.1.0/24"
    }, {
    name             = "db"
    address_prefixes = "10.0.2.0/24"
    }
  ]

  # Tags to categorize resources (useful for billing, organization)
  tags = {
    Env  = "Dev"
    Team = "DevOps"
  }

  # Make sure the VNet creation depends on the resource group
  depends_on = [azurerm_resource_group.base]
}

# Module to create a network security group (NSG)
module "nsg" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/security-group"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location

  # Security rules for the NSG
  nsg_info = {
    name = "web-nsg" # NSG name
    security_rules = [{
      name                   = "openssh" # Rule to allow SSH access
      priority               = 1000      # Rule priority
      direction              = "Inbound" # Direction of the rule
      protocol               = "Tcp"     # Protocol (TCP)
      destination_port_range = 22        # Port for SSH
      access                 = "Allow"   # Allow SSH access
      }, {
      name                   = "openhttp" # Rule to allow HTTP access
      priority               = 1010       # Rule priority
      direction              = "Inbound"  # Direction of the rule
      protocol               = "Tcp"      # Protocol (TCP)
      destination_port_range = 80         # Port for HTTP
      access                 = "Allow"    # Allow HTTP access
      }
    ]
  }

  # Tags to categorize resources
  tags = {
    Env  = "qa"
    Team = "DevOps"
  }

  # Ensure the NSG is created after the resource group
  depends_on = [azurerm_resource_group.base]
}

# Module to create a network interface (NIC) with a public IP and NSG
module "network_interface" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/Network-Interface"
  nic_count      = 2 # Number of NICs to create
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location

  # Public IP address configuration (Static IP)
  pip_address = {
    name              = "web-pip" # Name for the public IP
    allocation_method = "Static"
  }

  interface_name = "web-nic" # Name of the NIC
  private_ip     = "Dynamic"
  nsg-id         = module.nsg.nsg_id         # Reference to the NSG created in the previous module
  subnets_id     = module.vnet.subnets_id[0] # Reference to the subnet created in the VNet module
  tags = {
    Env  = "dev"
    Team = "DevOps"
  }

  # Ensure NIC is created after VNet subnets are available
  depends_on = [module.vnet.subnets_id]
}

# Module to create a virtual machine (VM) with an associated NIC, NSG, and public IP
module "virtual_machine" {
  source               = "github.com/VenkeyBoda/Modules_TF//Azure/Virtual_Machine"
  vm_count             = 2 # Number of VMs to create
  resource_group       = azurerm_resource_group.base.name
  location             = azurerm_resource_group.base.location
  nic_id               = module.network_interface.nic_id
  virtual_machine_name = "web-VM"
  username             = "devops"
  public_key_path      = "~/.ssh/id_rsa.pub"
  web_private_key      = "~/.ssh/id_rsa"
  vm_publisher         = "Canonical"
  offer_image          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts"
  image_version        = "latest"
  script               = "./script.sh"

  # Ensure VM creation depends on the NIC, NSG, and VNet resources
  depends_on = [
    module.network_interface.nic_id,
    module.nsg.nsg_id,
    module.vnet.subnet_id
  ]
}
