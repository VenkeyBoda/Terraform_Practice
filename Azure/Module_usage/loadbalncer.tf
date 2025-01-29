# Module to create an Azure Load Balancer for distributing traffic
module "azure_loadbalancer" {
  source           = "github.com/VenkeyBoda/Modules_TF//Azure/Loadbalancer"
  lb_name          = "healet-lb"
  resource_group   = azurerm_resource_group.base.name
  location         = azurerm_resource_group.base.location
  frontend_ip_name = "healet-ip"
  lb_backend_name  = "test-pool"
  nic_count        = 2
  nic_id           = module.network_interface.nic_id
  lb_probe_name    = "healet-healthcheck"
  lb_rule_name     = "test-healet"
}
