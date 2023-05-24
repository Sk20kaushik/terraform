resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc"
    Purpose = "Jenkins Demo"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "public"
  }
}


resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "first_public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.first_ig.id
  }
  
  tags = {
    Name = "first_public_rt"
  }
}

resource "aws_route_table_association" "route_first_public" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.first_public_rt.id
  
}

resource "aws_internet_gateway" "first_ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "first_ig"
  }
}

resource "aws_instance" "connect" {
  ami           = "ami-051ed863837a0b1b6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
  key_name   = "ncalfkey"
  tags = {
    Name = "first_instance"
  }
}
