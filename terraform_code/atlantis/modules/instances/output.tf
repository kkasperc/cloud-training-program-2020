output "aws_bastion_instance_name" {
  value = aws_instance.BASTION_HOST.name
  }
output "aws_bastion_instance_id" {
  value = aws_instance.BASTION_HOST.id
}

output "aws_atlantis_instance_name" {
  value = aws_instance.ATLANTIS_HOST.name
}

output "aws_atlantis_instance_id" {
  value = aws_instance.ATLANTIS_HOST.id
}