resource "aws_vpc" "rest-k8s" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = join(var.common_delimiter, ["vpc", local.workspace_name])
  }
}

resource "aws_subnet" "rest-k8s" {
  for_each = { for az in var.availability_zones : az => az }

  vpc_id                  = aws_vpc.rest-k8s.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(var.availability_zones, each.value))
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = join(var.common_delimiter, ["sb", each.value, local.workspace_name])
  }
}

resource "aws_internet_gateway" "rest-k8s" {
  vpc_id = aws_vpc.rest-k8s.id
  tags = {
    Name = join(var.common_delimiter, ["ig", local.workspace_name])
  }
}

resource "aws_route_table" "rest-k8s" {
  vpc_id = aws_vpc.rest-k8s.id

  tags = {
    Name = join(var.common_delimiter, ["rt", local.workspace_name])
  }
}

resource "aws_route" "rest-k8s" {
  route_table_id         = aws_route_table.rest-k8s.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rest-k8s.id
}

resource "aws_route_table_association" "rest-k8s" {
  for_each = aws_subnet.rest-k8s

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rest-k8s.id
}
