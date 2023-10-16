terraform {
  required_providers {
    sdwan = {
      source  = "CiscoDevNet/sdwan"
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
  source               = "../modules/feature_templates/system"
  template_name        = var.system_template_name
  template_description = var.system_template_description
  hostname             = var.hostname
  system_ip            = var.system_ip
}

module "ntp" {
  source = "../modules/feature_templates/ntp"
  template_name        = var.ntp_template_name
  template_description = var.ntp_template_description
}

module "vpn0" {
  source = "../modules/feature_templates/vpn0"
  template_name        = var.vpn0_template_name
  template_description = var.vpn0_template_description
}

module "vpn512" {
  source = "../modules/feature_templates/vpn512"
  template_name        = var.vpn512_template_name
  template_description = var.vpn512_template_description
}

module "vpn512_interface" {
  source               = "../modules/feature_templates/vpn512_interface"
  template_name        = var.vpn512_site_template_name
  template_description = var.vpn512_site_template_description
  interface_ip         = var.vpn512_site_interface_ip
}

module "vpn0_internet_interface" {
  source                = "../modules/feature_templates/vpn0_interface"
  template_name         = var.vpn0_interface1_template_name
  template_description  = var.vpn0_interface1_template_description
  interface_name        = var.interface1_name
  interface_description = var.interface1_description
  color                 = var.interface1_color
}

module "vpn0_mpls_interface" {
  source                = "../modules/feature_templates/vpn0_interface"
  template_name         = var.vpn0_interface2_template_name
  template_description  = var.vpn0_interface2_template_description
  interface_name        = var.interface2_name
  interface_description = var.interface2_description
  color                 = var.interface2_color
}

module "service_vpn10" {
  source                   = "../modules/feature_templates/service_vpn"
  vpn_template_name        = var.service_vpn10_site_template_name
  vpn_template_description = var.service_vpn10_site_template_description
  vpn_id                   = var.service_vpn10_id
  prefix                   = var.prefix_vpn10
  next_hop1                = var.next_hop_vpn10
}

module "service_vpn11" {
  source                   = "../modules/feature_templates/service_vpn"
  vpn_template_name        = var.service_vpn11_site_template_name
  vpn_template_description = var.service_vpn11_site_template_description
  vpn_id                   = var.service_vpn11_id
  prefix                   = var.prefix_vpn11
  next_hop1                = var.next_hop_vpn11
}

module "service_vpn10_interface" {
  source                = "../modules/feature_templates/service_vpn_interface"
  template_name         = var.service_vpn10_interface_template_name
  template_description  = var.service_vpn10_interface_template_description
  interface_name        = var.service_vpn10_interface_name
  interface_description = var.service_vpn10_interface_description
  interface_ip          = var.service_vpn10_interface_ip
}

module "service_vpn11_interface" {
  source                = "../modules/feature_templates/service_vpn_interface"
  template_name         = var.service_vpn11_interface_template_name
  template_description  = var.service_vpn11_interface_template_description
  interface_name        = var.service_vpn11_interface_name
  interface_description = var.service_vpn11_interface_description
  interface_ip          = var.service_vpn11_interface_ip
}

resource "sdwan_feature_device_template" "device_template_1" {
  name        = var.device_template_name
  description = var.device_template_description
  device_type = "vedge-C8000V"
  device_role = "sdwan-edge"
  general_templates = [{
    id   = module.ntp.ntp_id
    type = module.ntp.ntp_templateType
    },
    {
      id   = module.system.system_id
      type = module.system.system_templateType
    },
    {
      id   = module.vpn0.vpn0_id
      type = module.vpn0.vpn0_templateType
      sub_templates = [{
        id   = module.vpn0_internet_interface.vpn0interface_id
        type = module.vpn0_internet_interface.vpn0interface_templateType
      },
      {
        id   = module.vpn0_mpls_interface.vpn0interface_id
        type = module.vpn0_mpls_interface.vpn0interface_templateType
      }
      ]
    },
    {
      id   = module.vpn512.vpn512_id
      type = module.vpn512.vpn512_templateType
      sub_templates = [{
        id   = module.vpn512_interface.vpn512interface_id
        type = module.vpn512_interface.vpn512interface_templateType
      }
      ]
    },
    {
      id   = module.service_vpn10.servicevpn_id
      type = module.service_vpn10.servicevpn_templateType
      sub_templates = [{
        id   = module.service_vpn10_interface.sericevpninterface_id
        type = module.service_vpn10_interface.servicevpninterface_templateType
        }
      ]
    },
    {
      id   = "acf5e09a-b727-4f4b-8b5c-bc9b5226c41b"
      type = "cisco_bfd"
    },
    {
      id   = "24636fc4-d4f8-431e-9187-4ecccd97e40e"
      type = "cedge_aaa" 
    },
    {
      id = "e3122050-db16-420a-9e88-54e33eafccd0"
      type = "cisco_omp"
    },
    {
      id = "efd82dad-74cc-4c79-ada2-7fbb4d4ec11e"
      type = "cisco_security"
    },
    {
      id = "1f9e98b9-f5b9-4dcf-b26a-05b711e519fc"
      type = "cedge_global"
    },
    {
      id = "1c7ce767-6b86-4805-aa42-3f04daf9df5f"
      type = "cli-template"
    }
  ]
}