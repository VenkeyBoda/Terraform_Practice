# Aws Provider source and version being used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }
  }
  required_version = ">= 1.11.0"
}

