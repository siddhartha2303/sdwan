terraform {
  required_providers {
    sdwan = {
      source = "ciscodevnet/sdwan"
    }
  }
}

provider "sdwan" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.1.10:8443"
  insecure = true
}

resource "sdwan_cisco_ntp_feature_template" "ntp" {
  name                    = var.template_name
  description             = var.template_description
  device_types            = ["vedge-C8000V"]
  servers = [
    {
      hostname_ip           = "time1.google.com"
      vpn_id                = 0
    }
  ]
}