###############################################################################################
## NETWORK
###############################################################################################

resource "oci_core_vcn" "default_oci_core_vcn" {
  cidr_blocks    = [local.oci_core_vcn_cidr]
  compartment_id = data.onepassword_item.oci_iad_tenancy_oid.password
  display_name   = "oci_jjsimpson_vcn"
  dns_label      = local.domain
  freeform_tags = {
    "provisioner" = "terraform"
  }
}
resource "oci_core_subnet" "default_oci_core_subnet_01" {
  depends_on     = [oci_core_vcn.default_oci_core_vcn]
  cidr_block     = "10.0.40.0/24"
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  display_name   = "oci_jjsimpson_vcn (default) OCI core subnet"
  dns_label      = "sub01"
  route_table_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
  vcn_id         = oci_core_vcn.default_oci_core_vcn.id
  # security_list_ids = [oci_core_default_security_list.default_security_list.id]
  freeform_tags = {
    "provisioner" = "terraform"
  }
}
resource "oci_core_subnet" "default_oci_core_subnet_02" {
  depends_on     = [oci_core_vcn.default_oci_core_vcn]
  cidr_block     = "10.0.41.0/24"
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  display_name   = "oci_jjsimpson_vcn (default) OCI core subnet"
  dns_label      = "sub02"
  route_table_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
  vcn_id         = oci_core_vcn.default_oci_core_vcn.id
  # security_list_ids = [oci_core_default_security_list.default_security_list.id]
  freeform_tags = {
    "provisioner" = "terraform"
  }
}

resource "oci_core_default_route_table" "default_oci_core_default_route_table" {
  route_rules {
    description       = "tf_route_table"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.default_oci_core_internet_gateway.id
  }
  manage_default_resource_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
}

resource "oci_core_internet_gateway" "default_oci_core_internet_gateway" {
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  display_name   = "Internet Gateway Default OCI core vcn"
  enabled        = "true"
  vcn_id         = oci_core_vcn.default_oci_core_vcn.id
  freeform_tags = {
    "provisioner" = "terraform"
  }
}
