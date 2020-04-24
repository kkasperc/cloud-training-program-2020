resource "aws_iam_policy" "Atlantispolicy" {
  name        = "atlantis-policy"
  description = "Atlantis Server policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_role" "Atlantis_Server_Role" {
  name = "Atlantis_Server_Role"
  description = "Role Policy for the Atlantis Servere"
  path = "/system/"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
  EOF
}
resource "aws_iam_role_policy_attachment" "Atlantis" {
  policy_arn = aws_iam_policy.Atlantispolicy.arn
  role = aws_iam_role.Atlantis_Server_Role.name
}
resource "aws_iam_instance_profile" "Atlantis_Profile" {
  name = "Atlantis_Profile"
  role = aws_iam_role.Atlantis_Server_Role.name
}