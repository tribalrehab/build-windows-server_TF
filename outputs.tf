output "Windowsserver-DNS" {
	value = aws_instance.tribe-windowsserver.public_dns
}

output "WindowsServerLogin" {
	value = "${rsadecrypt(aws_instance.tribe-windowsserver.password_data,tls_private_key.tribe-privatekey.private_key_pem)}"
	sensitive = true
}
