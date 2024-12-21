###############################################################################################
## oci terraform provider
## https://registry.terraform.io/providers/oracle/oci/latest/docs
###############################################################################################

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.64.0"
    }
    onepassword = {
      source  = "1password/onepassword"
      version = ">=1.4.3"
    }
  }
}

provider "onepassword" { #pycharm will yell that it's broken, but it works

}

provider "oci" {
  user_ocid    = data.onepassword_item.oci_iad_tfuser_ocid.password
  fingerprint  = data.onepassword_item.oci_iad_tfuser_fingerprint.password
  tenancy_ocid = data.onepassword_item.oci_iad_tenancy_oid.password
  region       = "us-ashburn-1"
  private_key  = data.onepassword_item.oci_iad_tfuser_key.password
}

