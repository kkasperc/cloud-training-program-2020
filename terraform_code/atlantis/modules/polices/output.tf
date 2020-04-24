output "atlantis_profile" {
  value = aws_iam_instance_profile.Atlantis_Profile
}

output "atlantis_profile_id" {
  value = aws_iam_instance_profile.Atlantis_Profile.id
}
