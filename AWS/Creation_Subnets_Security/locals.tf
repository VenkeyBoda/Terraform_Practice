locals {
  anywhere                   = "0.0.0.0/0"
  public_subnet_count        = length(var.subnets_public)
  private_subnet_count       = length(var.subnets_private)
  web_security_ingress_count = length(var.web_security_group.rules)
  db_security_ingress_count  = length(var.db_security_group.rules)
}