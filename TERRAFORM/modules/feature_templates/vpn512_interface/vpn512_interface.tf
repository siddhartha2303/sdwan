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

resource "sdwan_cisco_vpn_interface_feature_template" "interface" {
  name                  = var.template_name
  description           = var.template_description
  device_types          = ["vedge-C8000V"]
  interface_name        = "GigabitEthernet8"
  interface_description = "***MGMT***"
  address_variable               = var.interface_ip
  shutdown              = false
}