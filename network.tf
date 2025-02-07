###############################################################################################
## NETWORK
###############################################################################################

resource "oci_core_vcn" "default_oci_core_vcn" {
  for_each = {
    for vcn_network in local.vcn_nets : vcn_network.vcn_key => vcn_network
  }
  cidr_blocks    = [each.value.net_cidr]
  compartment_id = data.onepassword_item.oci_iad_tenancy_oid.password
  display_name   = each.value.net_name
  dns_label      = each.value.net_domain
  freeform_tags = {
    "provisioner" = "terraform"
  }
}

resource "oci_core_subnet" "default_oci_core_subnet" {
  depends_on = [oci_core_vcn.default_oci_core_vcn]
  for_each = {
    for sub_network in local.vcn_nets : sub_network.sub_key => sub_network
  }
  cidr_block     = cidrsubnet(each.value.net_cidr, 2, each.value.sub_network)
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  display_name   = each.value.sub_name
  dns_label      = each.value.sub_domain
  prohibit_public_ip_on_vnic = each.value.sub_pub
  # route_table_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
  vcn_id         = oci_core_vcn.default_oci_core_vcn[each.value.vcn_key].id
  # security_list_ids = [oci_core_default_security_list.default_security_list.id]
  freeform_tags = {
    "provisioner" = "terraform"
  }
}

# resource "oci_core_default_route_table" "default_oci_core_default_route_table" {
#   route_rules {
#     description       = "tf_route_table"
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_internet_gateway.default_oci_core_internet_gateway.id
#   }
#   manage_default_resource_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
# }
#
# resource "oci_core_internet_gateway" "default_oci_core_internet_gateway" {
#   compartment_id = data.onepassword_item.oci_iad_compartment_id.password
#   display_name   = "Internet Gateway Default OCI core vcn"
#   enabled        = "true"
#   vcn_id         = oci_core_vcn.default_oci_core_vcn.id
#   freeform_tags = {
#     "provisioner" = "terraform"
#   }
# }
