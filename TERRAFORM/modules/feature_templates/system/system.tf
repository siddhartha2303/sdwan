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