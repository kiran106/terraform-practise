resource "aws_vpc" "mrudula-vpc" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_internet_gateway" "mrudula-vpc-igw" {
    vpc_id = aws_vpc.mrudula-vpc.id
}
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.mrudula-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mrudula-vpc-igw.id
    }
  
}

resource "aws_subnet" "mrudula_pub_subnet" {
  vpc_id = aws_vpc.mrudula-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "mrudula_pvt_subnet" {
    vpc_id = aws_vpc.mrudula-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
  
}

resource "aws_route_table" "RT-public" {
    vpc_id = aws_vpc.mrudula-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mrudula-vpc-igw.id
    }

}
resource "aws_route_table" "RT-private" {
    vpc_id = aws_vpc.mrudula-vpc.id

  
}

resource "aws_route_table_association" "RT-public-association" {
    subnet_id = aws_subnet.mrudula_pub_subnet.id

    route_table_id = aws_route_table.RT-public.id
}

resource "aws_route_table_association" "RT-private-association" {
  
  subnet_id = aws_subnet.mrudula_pvt_subnet.id
  route_table_id = aws_route_table.RT-private.id
}

resource "aws_instance" "mrudula-web-server" {
    ami = "ami-007020fd9c84e18c7"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.mrudula_pub_subnet.id
    key_name = "aws-demo-key"
}
  


