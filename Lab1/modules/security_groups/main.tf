module "ingress_rules" {
  source = "./flatten"
  rules  = var.ingress_rules
}

module "egress_rules" {
  source = "./flatten"
  rules  = var.egress_rules
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules" {
  count             = length(module.ingress_rules.out)
  security_group_id = aws_security_group.this.id

  description                  = module.ingress_rules.out[count.index].description
  from_port                    = module.ingress_rules.out[count.index].from_port
  to_port                      = module.ingress_rules.out[count.index].to_port
  ip_protocol                  = module.ingress_rules.out[count.index].protocol
  cidr_ipv4                    = module.ingress_rules.out[count.index].cidr_ipv4
  referenced_security_group_id = module.ingress_rules.out[count.index].security_group_id

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "egress_rules" {
  count             = length(module.egress_rules.out)
  security_group_id = aws_security_group.this.id

  description                  = module.egress_rules.out[count.index].description
  from_port                    = module.egress_rules.out[count.index].from_port
  to_port                      = module.egress_rules.out[count.index].to_port
  ip_protocol                  = module.egress_rules.out[count.index].protocol
  cidr_ipv4                    = module.egress_rules.out[count.index].cidr_ipv4
  referenced_security_group_id = module.egress_rules.out[count.index].security_group_id

  tags = var.tags
}
