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

resource "sdwan_cisco_vpn_feature_template" "vpn512" {
  name                    = var.template_name
  description             = var.template_description
  device_types            = ["vedge-C8000V"]
  vpn_id                  = "512"

  ipv4_static_routes = [
    {
      prefix   = "0.0.0.0/0"
      next_hops = [
        {
          address  = var.next_hop512
        }
      ]
    }
  ]
}