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

resource "sdwan_cisco_vpn_feature_template" "servicevpn" {
  name                    = var.vpn_template_name
  description             = var.vpn_template_description
  device_types            = ["vedge-C8000V"]
  vpn_id                  = var.vpn_id

  ipv4_static_routes = [
    {
      prefix_variable   = var.prefix
      next_hops = [
        {
          address_variable  = var.next_hop1
        }
      ]
    }
  ]
}