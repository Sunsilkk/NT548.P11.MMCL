# Định nghĩa giá trị cục bộ để xác định subnet nào cần NAT Gateway
locals {
  nat_gateway_subnets = [
    for subnet in var.public_subnets : subnet if subnet.nat_gateway
  ]
}

# Tạo một Virtual Private Cloud (VPC) với CIDR block và các tùy chọn DNS được chỉ định
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}

# Tạo các subnet công khai trong các vùng sẵn có được chỉ định
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnets[count.index].cidr_block
  availability_zone       = var.public_subnets[count.index].availability_zone

  tags = merge(
    {
      "Name" = "${var.name}-private-${var.public_subnets[count.index].availability_zone}"
    },
    var.tags,
  )
}

# Tạo bảng định tuyến cho các subnet công khai
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "${var.name}-public" },
    var.tags,
  )
}

# Liên kết các subnet công khai với bảng định tuyến công khai
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

# Tạo các subnet riêng tư trong các vùng sẵn có được chỉ định
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index].cidr_block
  availability_zone = var.private_subnets[count.index].availability_zone

  tags = merge(
    {
      "Name" = "${var.name}-private-${var.private_subnets[count.index].availability_zone}"
    },
    var.tags,
  )
}

# Tạo bảng định tuyến cho các subnet riêng tư
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "${var.name}-private" },
    var.tags,
  )
}

# Liên kết các subnet riêng tư với bảng định tuyến riêng tư
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# Tạo một Internet Gateway cho VPC nếu tồn tại các subnet cần NAT Gateway
resource "aws_internet_gateway" "this" {
  count  = length(local.nat_gateway_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags,
  )
}

# Cấp phát Elastic IP cho mỗi subnet có NAT Gateway
resource "aws_eip" "this" {
  count  = length(local.nat_gateway_subnets)
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.name}-nat-eip-${local.nat_gateway_subnets[count.index].availability_zone}"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.this]
}

# Tạo một NAT Gateway trong mỗi subnet công khai cần nó
resource "aws_nat_gateway" "this" {
  count         = length(local.nat_gateway_subnets)
  allocation_id = element(aws_eip.this.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    {
      Name = "${var.name}-nat-gateway-${local.nat_gateway_subnets[count.index].availability_zone}"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.this]
}
