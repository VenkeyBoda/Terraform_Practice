# ==========================
# Local Variables
# ==========================

locals {
  anywhere                   = "0.0.0.0/0"                          # CIDR block that allows access from anywhere
  public_subnet_count        = length(var.subnets_public)           # Count of public subnets defined in the variable
  private_subnet_count       = length(var.subnets_private)          # Count of private subnets defined in the variable
  web_security_ingress_count = length(var.web_security_group.rules) # Count of ingress rules for the web security group
  db_security_ingress_count  = length(var.db_security_group.rules)  # Count of ingress rules for the database security group
}
