variable "interface1_name" {
  type    = string
  default = "var_vpn0_internet_interface_name"
}

variable "interface1_description" {
  type    = string
  default = "var_vpn0_internet_interface_description"
}

variable "interface1_color" {
  type    = string
  default = "var_vpn0_internet_interface_color"
}

variable "interface2_name" {
  type    = string
  default = "var_vpn0_mpls_interface_name"
}

variable "interface2_description" {
  type    = string
  default = "var_vpn0_mpls_interface_description"
}

variable "interface2_color" {
  type    = string
  default = "var_vpn0_mpls_interface_color"
}

variable "service_vpn10_site_template_name" {
  type = string
}

variable "service_vpn10_site_template_description" {
  type = string
}


variable "service_vpn10_id" {
  type = string
}

variable "prefix_site" {
  type    = string
  default = "var_vpn10_route_prefix"
}

variable "next_hop_site" {
  type    = string
  default = "var_vpn10_route_nexthop"
}

variable "vpn512_site_template_name" {
  type = string
}

variable "vpn512_site_template_description" {
  type = string
}

variable "vpn512_site_interface_ip" {
  type    = string
  default = "var_vpn512_interface_ip"
}

variable "system_template_name" {
  type = string
}

variable "system_template_description" {
  type = string
}

variable "hostname" {
  type    = string
  default = "var_system_hostname"

}

variable "system_ip" {
  type    = string
  default = "var_system_ip"
}

variable "service_vpn10_interface_template_name" {
  type = string
}

variable "service_vpn10_interface_template_description" {
  type = string
}

variable "service_vpn10_interface_name" {
  type    = string
  default = "var_service_vpn10_interface_name"
}

variable "service_vpn10_interface_description" {
  type    = string
  default = "var_service_vpn10_interface_description"
}

variable "service_vpn10_interface_ip" {
  type    = string
  default = "var_service_vpn10_interface_ip"
}

variable "device_template_name" {
  type = string
}

variable "device_template_description" {
  type = string
}

variable "vpn0_interface1_template_name" {
  type = string
}

variable "vpn0_interface1_template_description" {
  type = string
}

variable "vpn0_interface2_template_name" {
  type = string
}

variable "vpn0_interface2_template_description" {
  type = string
}