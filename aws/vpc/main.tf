resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.name
  }
}

# Build subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.zones, count.index)
  cidr_block              = element(var.public_subnets, count.index)

  tags = {
    Name               = "${format("pub-%s-%s-%d", var.name, element(var.zones, count.index),  length(var.zones) )}"
    immutable_metadata = "{ \"purpose\": \"public-${var.name}\" }"
    terraform          = "true"
  }
}

resource "aws_subnet" "private" {
  count                   = length(var.private_subnets)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.zones, count.index)
  cidr_block              = element(var.private_subnets, count.index)

  tags = {
    Name               = "${format("priv-%s-%s-%d", var.name, element(var.zones, count.index), length(var.zones))}"
    immutable_metadata = "{ \"purpose\": \"private-${var.name}\" }"
    terraform          = "true"
  }
}

# Create gateways
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "igw-${var.name}"
    terraform = "true"
  }
}

resource "aws_eip" "nat_eips" {
  count = length(var.zones)
  vpc   = "true"
}

resource "aws_nat_gateway" "nats" {
  count         = length(var.zones)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.nat_eips.*.id, count.index)
  depends_on    = [aws_internet_gateway.igw]
}

# Create route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "rt-${var.name}-public"
    terraform = "true"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.zones)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format(
      "rt-%s-private-%s-%s",
      var.name,
      element(var.zones, count.index),
      floor(count.index / length(var.zones)),
    )
    terraform = "true"
  }
}

# Associate gateways to route tables as default routes
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public.id
}

resource "aws_route" "private" {
  count                  = length(var.zones)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nats.*.id, count.index)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
}


# Associate peering connections to route tables
resource "aws_route" "public_peers" {
  count                     = var.num_peers
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.peers[count.index % var.num_peers]["cidr"]
  vpc_peering_connection_id = var.peers[count.index % var.num_peers]["pcx"]
}

resource "aws_route" "private_peers" {
  count                     = var.num_peers * length(var.zones)
  route_table_id            = aws_route_table.private[floor(count.index / var.num_peers)].id
  destination_cidr_block    = var.peers[count.index % var.num_peers]["cidr"]
  vpc_peering_connection_id = var.peers[count.index % var.num_peers]["pcx"]
}


# Associate subnets to route tables
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}


