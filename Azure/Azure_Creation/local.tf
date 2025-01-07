# ==========================
# Local Variables
# ==========================
locals {
  virtual_netwok_count = length(var.virtual_network_info)
  subnets_count        = length(var.subnets_info)

}
