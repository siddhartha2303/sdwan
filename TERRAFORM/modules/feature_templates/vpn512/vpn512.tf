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

resource "sdwan_cisco_vpn_feature_template" "vpn512" {
  name                    = "feature_c8k_vpn512"
  description             = "Feature Template for C8000V VPN 512"
  device_types            = ["vedge-C8000V"]
  vpn_id                  = "512"

  ipv4_static_routes = [
    {
      prefix   = "0.0.0.0/0"
      next_hops = [
        {
          address  = "192.168.150.1"
        }
      ]
    }
  ]
}