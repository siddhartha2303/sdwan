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
  name                  = "feature_c8k_vpn0_interface"
  description           = "Feature Template for C8000v VPN 0 Interface"
  device_types          = ["vedge-C8000V"]
  interface_name        = var.interface_name
  interface_description = var.interface_description
  dhcp          = true
  dhcp_distance = 1
  tunnel_interface_encapsulations = [
    {
      encapsulation = "ipsec"
    }
  ]
  tunnel_interface_color                         = "biz-internet"
  tunnel_interface_allow_all                     = false
  tunnel_interface_allow_bgp                     = false
  tunnel_interface_allow_dhcp                    = true
  tunnel_interface_allow_dns                     = true
  tunnel_interface_allow_icmp                    = true
  tunnel_interface_allow_ssh                     = true
  tunnel_interface_allow_netconf                 = true
  tunnel_interface_allow_ntp                     = true
  tunnel_interface_allow_ospf                    = false
  tunnel_interface_allow_stun                    = false
  tunnel_interface_allow_snmp                    = false
  tunnel_interface_allow_https                   = false
  shutdown                                       = false
  qos_adaptive                                   = true
  nat                                            = false
}