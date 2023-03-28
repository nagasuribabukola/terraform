resource "aws_vpc" "ntier" {
  cidr_block = var.vpc_subnets.vpc_iprange
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count             = length(var.vpc_subnets.names)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = cidrsubnet(var.vpc_subnets.vpc_iprange, 8, count.index)
  availability_zone = "${var.region}${var.vpc_subnets.availability_zone[count.index]}"
  tags = {
    Name = var.vpc_subnets.names[count.index]
  }

  depends_on = [
    aws_vpc.ntier
  ]
}