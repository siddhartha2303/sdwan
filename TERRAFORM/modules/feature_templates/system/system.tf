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

resource "sdwan_cisco_system_feature_template" "system" {
  name               = var.template_name
  description        = var.template_description
  device_types       = ["vedge-C8000V"]
  timezone           = "America/Los_Angeles"
  hostname_variable           = var.hostname
  system_ip_variable             = var.system_ip
  site_id_variable               = "var_site_id"
  console_baud_rate     = "9600"
}