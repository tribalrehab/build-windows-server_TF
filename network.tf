# create vpc
resource "aws_vpc" "tribe-vpc" {
	cidr_block       = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_hostnames = true
	tags = {
		Name = "tribe-vpc"
	}
}

# create route table
resource "aws_route_table" "tribe-route" {
	vpc_id = "${aws_vpc.tribe-vpc.id}"
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.tribe-igw.id}"
	}
	
	tags = {
		name = "tribe-route"
	}
}

# create subnet
resource "aws_subnet" "management-subnet" {
    vpc_id = "${aws_vpc.tribe-vpc.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
	
	tags = {
		Name = "management-subnet"
    }
}

# create subnet
resource "aws_subnet" "clients-subnet" {
    vpc_id = "${aws_vpc.tribe-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
	
	tags = {
		Name = "clients-subnet"
    }
}

# associate subnet with route table
resource "aws_route_table_association" "tribe-route-subnet"{
	subnet_id = "${aws_subnet.management-subnet.id}"
	route_table_id = "${aws_route_table.tribe-route.id}"
}

# create internet gateway
resource "aws_internet_gateway" "tribe-igw" {
    vpc_id = "${aws_vpc.tribe-vpc.id}"
	
	tags = {
        Name = "tribe-igw"
    }
}
