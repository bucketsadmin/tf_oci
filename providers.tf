###############################################################################################
## PROVIDERS
## https://registry.terraform.io/providers/oracle/oci/latest/docs
###############################################################################################

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.21"
    }
    onepassword = {
      source  = "1password/onepassword"
      version = "~> 2.1"
    }
  }
}

provider "onepassword" {
  url = "https://op-api.jjsimpson.xyz"
}

provider "oci" {
  user_ocid    = data.onepassword_item.oci_iad_tfuser_ocid.password
  fingerprint  = data.onepassword_item.oci_iad_tfuser_fingerprint.password
  tenancy_ocid = data.onepassword_item.oci_iad_tenancy_oid.password
  region       = "us-ashburn-1"
  private_key  = data.onepassword_item.oci_iad_tfuser_key.private_key
}
