# Terraform Modules for Web Server Setup

This repository contains Terraform modules to create a Virtual Private Cloud (VPC), Security Groups, EC2 instances, an RDS database, and a Load Balancer in AWS. This setup is designed for a simple web server application with a database.

## Modules

### 1. **VPC Module**
   This module creates a Virtual Private Cloud (VPC), public and private subnets, and defines the availability zones.

   **Inputs**:
   - `vpc_cidr`: (string) The CIDR block for the VPC (e.g., `"10.0.0.0/16"`).
   - `vpc_name`: (string) The name of the VPC (e.g., `"web server"`).
   - `public_cidr`: (list(string)) A list of CIDR blocks for public subnets (e.g., `["10.0.0.0/24", "10.0.1.0/24"]`).
   - `public_az`: (list(string)) A list of availability zones for the public subnets (e.g., `["ap-south-1a", "ap-south-1b"]`).
   - `private_cidr`: (list(string)) A list of CIDR blocks for private subnets (e.g., `["10.0.2.0/24", "10.0.3.0/24"]`).
   - `private_az`: (list(string)) A list of availability zones for the private subnets (e.g., `["ap-south-1a", "ap-south-1b"]`).

   **Outputs**:
   - `vpc_id`: (string) The ID of the created VPC.
   - `public_subnet_id`: (list(string)) A list of IDs for the public subnets.
   - `private_subnet_id`: (list(string)) A list of IDs for the private subnets.

### 2. **Security Group Module**
   This module creates security groups for the web server and database with custom rules for traffic.

   **Inputs**:
   - `vpc_id`: (string) The ID of the VPC to associate with the security group.
   - `web_security_group_name`: (string) Name of the web security group (e.g., `"web-sg"`).
   - `web_security_group_description`: (string) Description for the web security group.
   - `web_security_group_rules`: (list(object)) Rules for the web security group (e.g., allow SSH and HTTP).
   - `db_security_group_name`: (string) Name of the database security group (e.g., `"db-sg"`).
   - `db_security_group_description`: (string) Description for the database security group.
   - `db_security_group`: (list(object)) Rules for the database security group (e.g., allow MySQL port).

   **Outputs**:
   - `web_security_id`: (string) The ID of the web security group.
   - `db_security_id`: (string) The ID of the database security group.

### 3. **EC2 Instance Module**
   This module provisions EC2 instances for your web server.

   **Inputs**:
   - `instance_count`: (number) The number of EC2 instances to create (e.g., `2`).
   - `key-info`: (map) Information about the SSH key to use for the instances.
   - `web_instance_name`: (string) Name of the EC2 instance (e.g., `"web-server"`).
   - `web_instance_type`: (string) Instance type (e.g., `"t2.micro"`).
   - `instance_associate_public_ip_address`: (bool) Whether to associate a public IP address (e.g., `true`).
   - `instance_username`: (string) The username to log in to the instance (e.g., `"ubuntu"`).
   - `filter_ami_name`: (string) The AMI name pattern to filter the available AMIs (e.g., `"ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"`).
   - `filter_ami_owner`: (string) The owner ID of the AMI (e.g., `"099720109477"`).
   - `subnet_id`: (string) The ID of the subnet for the EC2 instance.
   - `vpc_security_group_ids`: (list(string)) Security group IDs to associate with the instance.
   - `script`: (string) Path to the custom script to run on instance startup.

   **Outputs**:
   - `web_url`: (string) The URL of the web server.
   - `ssh_command`: (string) The SSH command to connect to the EC2 instance.
   - `deploy_server`: (string) Information about the deployed HTTP server.

### 4. **RDS Database Module**
   This module provisions an RDS database.

   **Inputs**:
   - `subnet_ids`: (list(string)) The IDs of the subnets to place the RDS instances in.
   - `subnet_group_name`: (string) The name of the database subnet group.
   - `database_name`: (string) The name of the RDS database.
   - `vpc_security_group_ids`: (list(string)) Security group IDs to associate with the RDS instance.

   **Outputs**:
   - `rds_endpoint`: (string) The endpoint of the RDS database.

### 5. **Load Balancer Module**
   This module provisions an AWS Network Load Balancer (NLB) for distributing traffic to EC2 instances.

   **Inputs**:
   - `target_instance_ids`: (list(string)) The EC2 instance IDs to attach to the load balancer.
   - `aws_lb_name`: (string) The name of the load balancer.
   - `aws_lb_type`: (string) Type of load balancer (e.g., `"network"`).
   - `subnets_id`: (list(string)) Subnet IDs for the load balancer.
   - `lb_environment`: (string) The environment for the load balancer (e.g., `"dev"`).
   - `vpc_id`: (string) The VPC ID.
   - `lb_protocol`: (string) The protocol used by the load balancer (e.g., `"TCP"`).
   - `lb_port`: (number) The port the load balancer listens on (e.g., `80`).

   **Outputs**:
   - `url`: (string) The URL of the Load Balancer.

## Usage

To use these modules in your Terraform project:

1. Clone this repository.
2. Modify the variables in the `main.tf` file to match your desired configuration.
3. Initialize Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply

# Outputs

The following outputs are generated:

* web-url = "http://<ec2_public_ip>"
* ssh-command = "ssh -i my-key-pair.pem ubuntu@<ec2_public_ip>"
* rds_endpoint = "<rds_endpoint>"
* http-website = "http://<ec2_public_ip>"
* lb_url = "<load_balancer_url>"
