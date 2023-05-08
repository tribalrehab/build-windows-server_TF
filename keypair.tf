# key pair 
resource "tls_private_key" "tribe-privatekey" {
	algorithm = "RSA"
	rsa_bits  = 4096
}

# create the key pair
resource "aws_key_pair" "tribe-keypair" {
	key_name   = "TRiBe-keypair"
	public_key = tls_private_key.tribe-privatekey.public_key_openssh
}

# Create local key file
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.tribe-keypair.key_name}.pem"
  content = tls_private_key.tribe-privatekey.private_key_pem
}
