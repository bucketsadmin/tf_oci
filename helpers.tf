locals {
  vcn_nets = flatten([
    for vcn_key, vcn in local.vcn_networks : [
      for sub_key, subnet in vcn.subnets : {
        vcn_key     = vcn_key
        sub_key     = sub_key
        net_name    = vcn.name
        net_domain  = vcn.domain
        net_cidr    = vcn.cidr
        sub_network = subnet.network
        sub_domain  = subnet.dns
        sub_name    = subnet.name
        sub_pub     = subnet.public
      }
    ]
  ])
}
