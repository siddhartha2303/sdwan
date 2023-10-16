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
}