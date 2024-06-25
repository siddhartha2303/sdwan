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

resource "sdwan_cisco_vpn_feature_template" "vpn0" {
  name                    = var.template_name
  description             = var.template_description
  device_types            = ["vedge-C8000V"]
  vpn_id                  = 0
  omp_admin_distance_ipv4 = 10
  omp_admin_distance_ipv6 = 10
  enhance_ecmp_keying     = true
  dns_hosts = [
    {
      hostname = "vbond-test-drive"
      ip       = ["10.1.1.5"]
    }
  ]
  ipv4_static_routes = [
    {
      prefix   = "0.0.0.0/0"
      next_hops = [
        {
          address  = var.next_hop0_internet
        },
        {
          address  = var.next_hop0_mpls
        }
      ]
    }
  ]
}