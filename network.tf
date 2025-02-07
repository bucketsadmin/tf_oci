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
  cidr_block                 = cidrsubnet(each.value.net_cidr, 2, each.value.sub_network)
  compartment_id             = data.onepassword_item.oci_iad_compartment_id.password
  display_name               = each.value.sub_name
  dns_label                  = each.value.sub_domain
  prohibit_public_ip_on_vnic = each.value.sub_pub
  # route_table_id = oci_core_vcn.default_oci_core_vcn.default_route_table_id
  vcn_id = oci_core_vcn.default_oci_core_vcn[each.value.vcn_key].id
  # security_list_ids = [oci_core_default_security_list.default_security_list.id]
  freeform_tags = {
    "provisioner" = "terraform"
  }
}
resource "oci_core_default_route_table" "default_oci_core_default_route_table" {
  for_each = {
    for route in local.vcn_nets : route.route_key => route
  }
  route_rules {
    description       = each.value.route_name
    destination       = each.value.route_dest
    destination_type  = each.value.route_type
    network_entity_id = each.value.route_gate
  }
  manage_default_resource_id = oci_core_vcn.default_oci_core_vcn[each.value.vcn_key].id
}

resource "oci_core_internet_gateway" "default_oci_core_internet_gateway" {
  compartment_id = data.onepassword_item.oci_iad_compartment_id.password
  display_name   = "Internet Gateway Default OCI core vcn"
  enabled        = "true"
  vcn_id         = oci_core_vcn.default_oci_core_vcn["primary"].id
  freeform_tags = {
    "provisioner" = "terraform"
  }
}

