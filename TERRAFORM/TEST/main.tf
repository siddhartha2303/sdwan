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
  name               = "TF_SYSTEM_1"
  description        = "My cisco system feature template"
  device_types       = ["vedge-C8000V"]
  hostname_variable  = "var_hostname"
  system_ip_variable = "var_system_ip"
  site_id_variable   = "var_site_id"
  console_baud_rate  = "115200"
}

resource "sdwan_feature_device_template" "device_template_1" {
  name        = "TF_DT1_ALL"
  description = "My device template 1"
  device_type = "vedge-C8000V"
  general_templates = [{
    id      = sdwan_cisco_system_feature_template.system.id
    version = sdwan_cisco_system_feature_template.system.version
    type    = sdwan_cisco_system_feature_template.system.template_type
  }]
}