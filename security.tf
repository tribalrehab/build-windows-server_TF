# create the security group to allow access to port 22/80/443/3389 for the webserver
resource "aws_security_group" "tribe-sg" {
	vpc_id = aws_vpc.tribe-vpc.id
	name = "allow_webserver_traffic"
	description = "Allow port 3389 inbound traffic"
    
	ingress {
		from_port = 3389
		to_port = 3389
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
