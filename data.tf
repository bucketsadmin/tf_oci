###############################################################################################
## DATA SOURCES
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
data "onepassword_item" "oci_iad_compartment_id" {
  vault = replace(data.onepassword_vault.secrets.id, "vaults/", "")
  title = "oci_iad_compartment_id"
}

###### OCI
data "oci_identity_availability_domain" "ad" {
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  ad_number      = 1
}
