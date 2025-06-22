resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow traffic from EKS worker nodes to RDS"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-rds-sg"
    }
  )
}

resource "aws_security_group_rule" "eks_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  description              = "Allow EKS nodes to connect to PostgreSQL"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}