locals {
  anywhere             = "0.0.0.0/0"
  public_subnet_count  = length(var.subnets_public)
  private_subnet_count = length(var.subnets_private)

}