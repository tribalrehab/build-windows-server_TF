provider "aws" {
	profile = "default"
	region  = "us-east-1"
	shared_credentials_files=["cred.txt"]
}

variable "tribe-script-version" {
	type = string
	default = "1.18"
}

# create the EC2 instance
resource "aws_instance" "tribe-windowsserver" {
	ami = "ami-024614f01f42eeb66"
	instance_type = "t2.micro"
	associate_public_ip_address = true
	vpc_security_group_ids = ["${aws_security_group.tribe-sg.id}"]
	subnet_id = "${aws_subnet.management-subnet.id}"
	key_name = aws_key_pair.tribe-keypair.key_name
	get_password_data = true
    tags = {
		Name = "windowsserver"
	}
	user_data = "${file("scripts/createdomain.txt")}"
}
