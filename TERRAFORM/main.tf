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

module "system" {
  source = "./modules/feature_templates/system"
  template_name = var.system_template_name
  template_description = var.system_template_description
  hostname = var.hostname
  system_ip = var.system_ip
  site_id = var.site_id

module "vpn0" {
  source = "./modules/feature_templates/vpn0"
}

module "vpn512" {
  source = "./modules/feature_templates/vpn512"
}

module "interface" {
  source = "./modules/feature_templates/vpn512_interface"
  template_name = var.vpn512_site_template_name
  template_description = var.vpn512_site_template_description
  interface_ip = var.vpn512_site_interface_ip
}

module "interface" {
  source = "./modules/feature_templates/vpn0_interface"
  interface_name = var.interface1_name
  interface_description = var.interface1_description
  color = var.interface1_color
}

module "interface" {
  source = "./modules/feature_templates/vpn0_interface"
  interface_name = var.interface2_name
  interface_description = var.interface2_description
  color = var.interface2_color
}

module "site_vpn10" {
  source = "./modules/feature_templates/service_vpn"
  vpn_template_name = var.service_vpn10_site_template_name
  vpn_template_description = var.service_vpn10_site_template_description
  vpn_id = var.service_vpn10_id
  prefix = var.prefix_site
  next_hop1 = var.next_hop_site
}


