terraform {
  backend "s3" {
    bucket = "eks-cluster" 
    key    = "EKS/terraform.tfstate"
    region = "ap-south-1"
  }
}
