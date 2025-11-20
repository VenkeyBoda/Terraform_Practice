terraform {
  required_version = ">= 1.0"

  # backend "s3" {
  #   bucket         = "venkat-backend-bitbucket"
  #   key            = "ec2/terraform.tfstate"
  #   region         = "ap-south-1"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.region
}
