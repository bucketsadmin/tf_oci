###############################################################################################
## MANIFEST
###############################################################################################

locals {
  domain            = "jjsimpson"
  oci_core_vcn_cidr = "10.0.40.0/22"

  vcn_networks = {
    primary = {
      name   = "oci_privnet_vcn"
      domain = "eastpriv"
      cidr   = "10.0.40.0/22"
      subnets = {
        sub_01 = {
          network = 0
          dns     = "sub01"
          name    = "OCI private subnet"
          public  = true
        }
      }
      routes = {
        default = {
          name = "oci_route_priv"
          dest = "0.0.0.0/0"
          gate = "none"
          type = "CIDR_BLOCK"
        }
      }
    }
  }
}
