
# AWS EC2 Web Instance Module

This Terraform module provisions an EC2 instance running Ubuntu 24.04, along with necessary resources like SSH key pairs, and web server deployment via a user-defined startup script. It also provides outputs for easy management of the created infrastructure.

## Prerequisites

- Terraform 1.x or higher
- AWS account with appropriate IAM permissions to create EC2 instances, security groups, key pairs, etc.

## Module Overview

This module creates:

- An SSH key pair using an existing public key.
- A security group (specified by security group IDs).
- A web EC2 instance running Ubuntu 24.04 based on user-defined AMI filters.
- An optional startup script execution on instance creation.
- Outputs for accessing the web server and SSH commands.

## Usage

### Example:

```hcl
module "web_instance" {
  source = "./path_to_this_module" # Path to the module
  
  key-info = {
    name             = "my-ssh-key"
    public_key_path  = "./my-ssh-key.pub"
    private_key_path = "./my-ssh-key.pem"
  }
  web_instance_name               = "my-web-instance"
  web_instance_type               = "t2.micro"
  instance_associate_public_ip_address = true
  instance_username              = "ubuntu"
  filter_ami_name                = "ubuntu-24.04"
  filter_ami_owner               = "099720109477" # Canonical Owner ID
  subnet_id                      = "subnet-12345678"
  vpc_security_group_ids         = "sg-12345678"
  script                         = "./init.sh" # Path to startup script
  instance_count                 = 1
}
```

## Inputs

| Name                             | Description                                                 | Type         | Default | Required |
|----------------------------------|-------------------------------------------------------------|--------------|---------|----------|
| `key-info`                       | Information for importing an existing SSH key pair          | `object({name = string, public_key_path = string, private_key_path = string})` | N/A     | Yes      |
| `web_instance_name`              | Name for the web instance                                  | `string`     | N/A     | Yes      |
| `web_instance_type`              | EC2 instance type (e.g., `t2.micro`, `t3.medium`)           | `string`     | N/A     | Yes      |
| `instance_associate_public_ip_address` | Whether to associate a public IP with the instance         | `bool`       | N/A     | Yes      |
| `instance_username`              | Username for SSH access (e.g., `ubuntu` for Ubuntu images)  | `string`     | N/A     | Yes      |
| `filter_ami_name`                | AMI name filter for selecting the appropriate Ubuntu AMI    | `string`     | N/A     | Yes      |
| `filter_ami_owner`               | AMI owner filter (use "099720109477" for Canonical)         | `string`     | N/A     | Yes      |
| `subnet_id`                      | Subnet ID for the EC2 instance                              | `string`     | N/A     | Yes      |
| `vpc_security_group_ids`         | Security group IDs for the EC2 instance                     | `string`     | N/A     | Yes      |
| `build_id`                       | Unique identifier for the build (useful in CI/CD pipelines) | `string`     | `"1"`   | No       |
| `script`                         | Path to a startup script to run on instance creation        | `string`     | N/A     | Yes      |
| `instance_count`                 | Number of EC2 instances to create                           | `number`     | `2`     | No       |

## Outputs

| Name                       | Description                                                    |
|----------------------------|----------------------------------------------------------------|
| `web_url`                   | The public URL of the web server (http://<public_ip>)          |
| `ssh_command`               | SSH command for connecting to the web server (`ssh -i <private_key_path> <username>@<public_ip>`) |
| `deploy_server`             | The URL for accessing the deployed web server                 |
| `ec2-instance_count`        | The total number of EC2 instances created                     |
| `instance_ids`              | The IDs of all EC2 instances created by the `web` resource     |

## Example Outputs

### Example 1: Web URL
After running `terraform apply`, you can access your web server using the URL:

```
Output:
web_url = http://<public_ip>
```

### Example 2: SSH Command
To connect to your EC2 instance via SSH, use the command:

```
Output:
ssh_command = ssh -i ./my-ssh-key.pem ubuntu@<public_ip>
```

### Example 3: Instance IDs
To get the instance IDs of all created instances:

```
Output:
instance_ids = [<instance_id_1>, <instance_id_2>]
```

## Notes

- Ensure the provided SSH key (`public_key_path` and `private_key_path`) is correctly configured in AWS.
- Make sure your AWS credentials are set up in your environment or via the AWS CLI (`aws configure`).
- The module supports creating multiple instances based on the `instance_count` variable.

