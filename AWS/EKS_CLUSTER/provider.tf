# Aws Provider source and version being used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.2"
    }
  }
  required_version = ">= 1.11.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
