output "application_server_name" {
  value = aws_security_group.sg_atlantis_instance_allow_ssh.name
}

output "security_group_allow_ssh"{
  value = aws_security_group.sg_allow_ssh.id
}

output "security_group_atlantis_instance_allow_ssh_id" {
  value = aws_security_group.sg_atlantis_instance_allow_ssh.id
}