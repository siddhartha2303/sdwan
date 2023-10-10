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

module "vpn0" {
  source = "./modules/feature_templates/vpn0"
}

module "vpn512" {
  source = "./modules/feature_templates/vpn512"
}

module "interface" {
  source = "./modules/feature_templates/vpn512_interface"
  template_name = var.vpn512_site1_template_name
  template_description = var.vpn512_site1_template_description
  interface_ip = var.vpn512_site1_interface_ip
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

module "site1_vpn10" {
  source = "./modules/feature_templates/service_vpn"
  vpn_template_name = var.service_vpn10_site1_template_name
  vpn_template_description = var.service_vpn10_site1_template_description
  vpn_id = var.service_vpn10_id
  prefix = var.prefix_site1
  next_hop1 = var.next_hop_site1
}

module "site2_vpn10" {
  source = "./modules/feature_templates/service_vpn"
  vpn_template_name = var.service_vpn10_site2_template_name
  vpn_template_description = var.service_vpn10_site2_template_description
  vpn_id = var.service_vpn10_id
  prefix = var.prefix_site2
  next_hop1 = var.next_hop_site2
}


