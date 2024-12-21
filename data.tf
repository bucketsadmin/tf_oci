###############################################################################################
## data sources
##
###############################################################################################
data "onepassword_vault" "secrets" {
  name = "secrets"
}



data "onepassword_item" "oci_iad_tenancy_oid" {
  vault = replace(data.onepassword_vault.secrets.id, "vaults/", "")
  title = "oci_iad_tenancy_oid"
}
data "onepassword_item" "oci_iad_tfuser_ocid" {
  vault = replace(data.onepassword_vault.secrets.id, "vaults/", "")
  title = "oci_iad_tfuser_ocid"
}
data "onepassword_item" "oci_iad_tfuser_fingerprint" {
  vault = replace(data.onepassword_vault.secrets.id, "vaults/", "")
  title = "oci_iad_tfuser_fingerprint"
}
data "onepassword_item" "oci_iad_tfuser_key" {
  vault = replace(data.onepassword_vault.secrets.id, "vaults/", "")
  title = "oci_iad_tfuser_key"
}
