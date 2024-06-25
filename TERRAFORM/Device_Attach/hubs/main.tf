terraform {
  required_providers {
    sdwan = {
      source = "CiscoDevNet/sdwan"
    }
  }
}

provider "sdwan" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.1.10:8443"
  insecure = true
}

resource "sdwan_attach_feature_device_template" "new_cedge" {
  id      = var.template_id
  version = var.template_version
  devices = [{
    id = var.device_id
    variables = {
      var_vpn0_internet_interface_name        = var.var_vpn0_internet_interface_name
      var_vpn0_internet_interface_description = var.var_vpn0_internet_interface_description
      var_vpn0_internet_interface_address     = var.var_vpn0_internet_interface_address
      var_vpn0_internet_interface_color       = var.var_vpn0_internet_interface_color
      var_vpn0_internet_nexthop               = var.var_vpn0_internet_nexthop
      var_vpn0_mpls_interface_name            = var.var_vpn0_mpls_interface_name
      var_vpn0_mpls_interface_description     = var.var_vpn0_mpls_interface_description
      var_vpn0_mpls_interface_address         = var.var_vpn0_mpls_interface_address
      var_vpn0_mpls_interface_color           = var.var_vpn0_mpls_interface_color
      var_vpn0_mpls_nexthop                   = var.var_vpn0_mpls_nexthop
      var_vpn10_route_prefix                  = var.var_vpn10_route_prefix
      var_vpn10_route_nexthop                 = var.var_vpn10_route_nexthop
      var_vpn11_route_prefix                  = var.var_vpn11_route_prefix
      var_vpn11_route_nexthop                 = var.var_vpn11_route_nexthop
      var_vpn512_interface_ip                 = var.var_vpn512_interface_ip
      var_vpn512_interface_name               = var.var_vpn512_interface_name
      var_next_hop_vpn512                     = var.var_next_hop_vpn512
      var_system_hostname                     = var.var_system_hostname
      var_system_ip                           = var.var_system_ip
      var_site_id                             = var.var_site_id
      var_service_vpn10_interface_name        = var.var_service_vpn10_interface_name
      var_service_vpn10_interface_description = var.var_service_vpn10_interface_description
      var_service_vpn10_interface_ip          = var.var_service_vpn10_interface_ip
      var_service_vpn11_interface_name        = var.var_service_vpn11_interface_name
      var_service_vpn11_interface_description = var.var_service_vpn11_interface_description
      var_service_vpn11_interface_ip          = var.var_service_vpn11_interface_ip      
    }
  }]
}