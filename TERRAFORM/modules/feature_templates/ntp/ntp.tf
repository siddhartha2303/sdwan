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

resource "sdwan_cisco_ntp_feature_template" "ntp" {
  name                    = "feature_c8k_ntp"
  description             = "Feature Template for C8000V NTP"
  device_types            = ["vedge-C8000V"]
  servers = [
    {
      hostname_ip           = "time1.google.com"
      vpn_id                = 0
    }
  ]
}