# ==========================
# Local Variables
# ==========================

locals {
  aws_subnet_count = length(var.subnets_info) # Count of subnets defined in the variable
}