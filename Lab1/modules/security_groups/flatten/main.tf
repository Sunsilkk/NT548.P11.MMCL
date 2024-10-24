locals {
  flatten_rules = flatten([
    for rule in var.rules : [
      for cidr_ipv4 in(length(rule.cidr_blocks) == 0 ? [null] : rule.cidr_blocks) : [
        for sg_id in(length(rule.security_groups) == 0 ? [null] : rule.security_groups) : {
          description       = rule.description
          from_port         = rule.from_port
          to_port           = rule.to_port
          protocol          = rule.protocol
          cidr_ipv4         = cidr_ipv4
          security_group_id = sg_id
        }
      ]
    ]
  ])
}
