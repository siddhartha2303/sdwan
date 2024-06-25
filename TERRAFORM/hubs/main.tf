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

# Define data sources to fetch template IDs
data "sdwan_cisco_bfd_feature_template" "bfd" {
  name = "BFD-dCloud-Feature"
}

data "sdwan_cedge_aaa_feature_template" "aaa" {
  name = "Factory_Default_AAA_Template"
}

data "sdwan_cisco_omp_feature_template" "omp" {
  name = "OMP-dCloud-Feature"
}

data "sdwan_cisco_security_feature_template" "security" {
  name = "Factory_Default_vEdge_Security_Template_V01"
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
  next_hop0_internet   = var.next_hop_vpn0_internet
  next_hop0_mpls       = var.next_hop_vpn0_mpls
}

module "vpn512" {
  source = "../modules/feature_templates/vpn512"
  template_name        = var.vpn512_template_name
  template_description = var.vpn512_template_description
  next_hop512          = var.next_hop_vpn512
}


module "vpn512_interface" {
  source               = "../modules/feature_templates/vpn512_interface"
  template_name        = var.vpn512_site_template_name
  template_description = var.vpn512_site_template_description
  interface_ip         = var.vpn512_site_interface_ip
  interface_name       = var.vpn512_site_interface_name
}

module "vpn0_internet_interface" {
  source                = "../modules/feature_templates/vpn0_interface"
  template_name         = var.vpn0_interface1_template_name
  template_description  = var.vpn0_interface1_template_description
  interface_name        = var.interface1_name
  interface_description = var.interface1_description
  interface_address     = var.interface1_address
  color                 = var.interface1_color
}

module "vpn0_mpls_interface" {
  source                = "../modules/feature_templates/vpn0_interface"
  template_name         = var.vpn0_interface2_template_name
  template_description  = var.vpn0_interface2_template_description
  interface_name        = var.interface2_name
  interface_description = var.interface2_description
  interface_address     = var.interface2_address
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
      id   = module.service_vpn11.servicevpn_id
      type = module.service_vpn11.servicevpn_templateType
      sub_templates = [{
        id   = module.service_vpn11_interface.sericevpninterface_id
        type = module.service_vpn11_interface.servicevpninterface_templateType
        }
      ]
    },
    {
      id   = data.sdwan_cisco_bfd_feature_template.bfd.id
      type = "cisco_bfd"
    },
    {
      id   = data.sdwan_cedge_aaa_feature_template.aaa.id
      type = "cedge_aaa" 
    },
    {
      id = data.sdwan_cisco_omp_feature_template.omp.id
      type = "cisco_omp"
    },
    {
      id = data.sdwan_cisco_security_feature_template.security.id
      type = "cisco_security"
    }
  ]
}