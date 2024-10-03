resource "aws_instance" "bastion" {
  ami                         = "ami-830c94e3"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  subnet_id                   = aws_subnet.public_subnets.id
  associate_public_ip_address = true

  tags = {
    Name = "bastion"
  }
}


resource "aws_instance" "app" {
  ami                         = "ami-830c94e3"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow_ssh_3000port.id]
  subnet_id                   = aws_subnet.private_subnets.id
  associate_public_ip_address = true

  tags = {
    Name = "app"
  }
}