# Terraform Infrastructure Deployment

## Overview
This Terraform configuration automates the deployment of an Azure infrastructure, including:
- A resource group in the Central India region
- A Virtual Network (VNet) with subnets
- A Network Security Group (NSG) with security rules
- Network Interfaces (NICs) with Public IP addresses
- Virtual Machines (VMs) with SSH access
- An Azure Load Balancer for traffic distribution

## Prerequisites
Before running this Terraform script, ensure you have:
- Terraform installed on your system
- Azure CLI installed and authenticated
- An existing SSH key pair for VM access

## Module Details

### Resource Group
Creates a resource group named **azure_modules** in the Central India region.

### Virtual Network (VNet)
Creates a virtual network named **ntier** with the following subnets:
- **web** (10.0.0.0/24)
- **app** (10.0.1.0/24)
- **db** (10.0.2.0/24)

### Network Security Group (NSG)
Creates an NSG named **web-nsg** with security rules:
- **SSH Access** (port 22, TCP, Allow)
- **HTTP Access** (port 80, TCP, Allow)

### Network Interface (NIC)
Creates two NICs with:
- Public IP allocation (Static)
- Private IP allocation (Dynamic)
- NSG association
- Subnet assignment

### Virtual Machine (VM)
Deploys two VMs with:
- OS: Ubuntu 22.04 LTS
- Username: `devops`
- SSH Key: `~/.ssh/id_rsa.pub`
- Startup Script: `nginx.sh`

### Azure Load Balancer
Deploys an Azure Load Balancer named **cafe-lb** with:
- A frontend IP configuration
- A backend pool
- A health probe
- A load balancing rule

## Inputs
| Variable | Description |
|----------|-------------|
| `resource_group` | Name of the resource group |
| `location` | Azure region for deployment |
| `network_info` | VNet address space and name |
| `subnets_info` | List of subnet configurations |
| `nsg_info` | NSG name and security rules |
| `nic_count` | Number of NICs to create |
| `pip_address` | Public IP address configuration |
| `virtual_machine_name` | Name of the virtual machine |
| `username` | SSH username for VM access |
| `public_key_path` | Path to the public SSH key |
| `vm_publisher` | VM image publisher |
| `offer_image` | OS image offer |
| `image_sku` | Image SKU |
| `image_version` | OS image version |
| `script` | Initialization script |
| `lb_name` | Name of the load balancer |

## Outputs
| Output | Description |
|--------|-------------|
| `web-url` | The public URL of the web server |
| `ssh_command` | SSH command to access the VM |
| `template_url` | Deployment template URL |
| `url_lb_ip_address` | Public IP address of the load balancer |

## Usage
1. Initialize Terraform:
   ```sh
   terraform init
   ```
2. Plan the deployment:
   ```sh
   terraform plan
   ```
3. Apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```
4. Retrieve the output values:
   ```sh
   terraform output
   ```
5. SSH into the VM:
   ```sh
   ssh -i ~/.ssh/id_rsa devops@<public-ip>
   ```
6. Access the web server via:
   ```
   http://<public-ip>
   ```

## Cleanup
To remove all resources:
```sh
terraform destroy -auto-approve
```

## Author
Boda Venkatesh

