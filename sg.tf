# first sg for port 22 from anywhere
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id



  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# Second sg for port 22 from anywhere

resource "aws_security_group" "allow_ssh_3000port" {
  name        = "allow_ssh_3000port"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id



  tags = {
    Name = "allow_ssh_3000port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_iipv4" {
  security_group_id = aws_security_group.allow_ssh_3000port.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_private" {
  security_group_id = aws_security_group.allow_ssh_3000port.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_private" {
  security_group_id = aws_security_group.allow_ssh_3000port.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}