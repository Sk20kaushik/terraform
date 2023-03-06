resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc"
    Purpose = "Jenkins Demo"
  }
}

resource "aws_subnet" "t-sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.0.0/24"

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "t-sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "private"
  }
}