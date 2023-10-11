terraform {
  required_providers {
    sdwan = {
      source  = "CiscoDevNet/sdwan"
      version = "0.2.7"
    }
  }
}

provider "sdwan" {
  username = "admin"
  password = "pocadmin"
  url      = "https://vmanage.dcloud.cisco.com:8443"
  insecure = true
}

resource "sdwan_attach_feature_device_template" "new_cedge" {
  id      = var.template_id
  version = var.template_version
  devices = [{
    id = var.device_id
    variables = {
        var_interface1_name                              = var.var_interface1_name
        var_interface1_description                       = var.var_interface1_description
        var_interface1_color                             = var.var_interface1_color
        var_interface2_name                              = var.var_interface2_name
        var_interface2_description                       = var.var_interface2_description
        var_interface2_color                             = var.var_interface2_color
        var_prefix_site                                  = var.var_prefix_site
        var_next_hop_site                                = var.var_next_hop_site
        var_vpn512_site_interface_ip                     = var.var_vpn512_site_interface_ip
        var_hostname                                     = var.var_hostname
        var_system_ip                                    = var.var_system_ip
        var_site_id                                      = var.var_site_id
        var_service_vpn10_interface_name                 = var.var_service_vpn10_interface_name
        var_service_vpn10_interface_description          = var.var_service_vpn10_interface_description
        var_service_vpn10_interface_ip                   = var.var_service_vpn10_interface_ip
    }
  }]
}