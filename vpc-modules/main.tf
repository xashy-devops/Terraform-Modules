###  Defining vpc resources...
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpccidr
  tags = {
    "Name" = "${var.project}-${var.Environment}-vpc"
  }
}

## subnets should be created...

resource "aws_subnet" "priv1-subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.priv1cidr
  availability_zone = var.az1
  tags = {
    "Name" = "${var.project}-${var.Environment}-priv1subnet"
  }
}

resource "aws_subnet" "priv2-subnet" {
  cidr_block = var.priv2cidr  
  vpc_id = aws_vpc.myvpc.id
  availability_zone = var.az2
  tags = {
    "Name" = "${var.project}-${var.Environment}-priv2subnet"
  }
}

# private route table

resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "${var.project}-${var.Environment}-priv-rt"
  }
}

# association for subnets  to the route table.tags

resource "aws_route_table_association" "priv1-subnet-association" {
subnet_id = aws_subnet.priv1-subnet.id
route_table_id = aws_route_table.priv-rt.id
}

resource "aws_route_table_association" "priv2-subnet-association" {
  subnet_id = aws_subnet.priv2-subnet.id
  route_table_id = aws_route_table.priv-rt.id
}



