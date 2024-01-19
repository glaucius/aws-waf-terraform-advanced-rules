### ip address set
resource "aws_wafv2_ip_set" "ip_set" {
  name               = "ip_set_name"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["1.1.1.1/32", "2.2.2.2/32"]
}
