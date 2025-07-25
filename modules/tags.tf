
resource "aws_ec2_tag" "karpenter_subnets" {
  for_each = toset(var.subnet_ids)

  resource_id = each.value
  key         = "karpenter.sh/discovery"
  value       = var.cluster_name
}

resource "aws_ec2_tag" "karpenter_sgs" {
  for_each = toset(var.sg_ids)

  resource_id = each.value
  key         = "karpenter.sh/discovery"
  value       = var.cluster_name
}
