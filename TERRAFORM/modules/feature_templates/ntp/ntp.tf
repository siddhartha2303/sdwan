resource "sdwan_cisco_ntp_feature_template" "ntp" {
  name                    = "feature_c8k_ntp"
  description             = "Feature Template for C8000V NTP"
  device_types            = ["vedge-C8000V"]
  servers = [
    {
      hostname_ip           = "time1.google.com"
      vpn_id                = 0
    }
  ]
}