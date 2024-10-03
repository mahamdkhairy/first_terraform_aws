# resource "aws_route_table" "second_rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "Public Subnet Route Table"
#   }
# }


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  # route {
  #   cidr_block             = aws_vpc.main.cidr_block
  #   egress_only_gateway_id = "local"
  # }

  tags = {
    Name = "public"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id


  # route {
  #   cidr_block             = aws_vpc.main.cidr_block
  #   egress_only_gateway_id = "local"
  # }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "rt_associate_public" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "rt_associate_private" {
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.private.id
}