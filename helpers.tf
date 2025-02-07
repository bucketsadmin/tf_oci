locals {
  vcn_nets = flatten([
    for vcn_key, vcn in local.vcn_networks : [
      for route_key, routes in vcn.routes : [
        for sub_key, subnet in vcn.subnets : {
          vcn_key     = vcn_key
          sub_key     = sub_key
          route_key   = route_key
          net_name    = vcn.name
          net_domain  = vcn.domain
          net_cidr    = vcn.cidr
          sub_network = subnet.network
          sub_domain  = subnet.dns
          sub_name    = subnet.name
          sub_pub     = subnet.public
          route_name  = routes.name
          route_dest  = routes.dest
          route_gate  = routes.gate
          route_type  = routes.type
        }
      ]
    ]
  ])
}
