data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = var.route_subnets.public_subnets
  }

  depends_on = [
    aws_subnet.subnets
  ]
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = var.route_subnets.private_subnets
  }

  depends_on = [
    aws_subnet.subnets
  ]
}