###############################################################################################
## MANIFEST
###############################################################################################

locals {
  domain            = "jjsimpson"
  oci_core_vcn_cidr = "10.0.40.0/22"

  vcn_networks = {
    primary = {
      name   = ""
      domain = ""
      subnets = {
        sub_01 = {
          network = cidrsubnet(local.oci_core_vcn_cidr, 8, 0)
          dns = ""
          name = ""
        }
      }
    }
  }
}