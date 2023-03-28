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

resource "aws_internet_gateway" "ntire_ig" {
  vpc_id = aws_vpc.ntier.id

  tags = {
    Name = "ntire_ig"
  }

  depends_on = [
    aws_subnet.subnets
  ]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ntier.id

  tags = {
    Name = "private_route"
  }

  depends_on = [
    aws_vpc.ntier,
    aws_subnet.subnets
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ntier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ntire_ig.id
  }

  tags = {
    Name = "public_route"
  }

  depends_on = [
    aws_vpc.ntier,
    aws_subnet.subnets,
    aws_internet_gateway.ntire_ig
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(var.route_subnets.private_subnets)
  subnet_id      = data.aws_subnets.private.ids[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.route_subnets.public_subnets)
  subnet_id      = data.aws_subnets.public.ids[count.index]
  route_table_id = aws_route_table.public.id
}