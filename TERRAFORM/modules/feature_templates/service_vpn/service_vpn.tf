terraform {
  required_providers {
    sdwan = {
      source = "CiscoDevNet/sdwan"
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

resource "sdwan_cisco_vpn_feature_template" "servicevpn" {
  name                    = var.vpn_template_name
  description             = var.vpn_template_description
  device_types            = ["vedge-C8000V"]
  vpn_id                  = var.vpn_id

  ipv4_static_routes = [
    {
      prefix   = var.prefix
      next_hops = [
        {
          address  = var.next_hop1
        }
      ]
    }
  ]
}