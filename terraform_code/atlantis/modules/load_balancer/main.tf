resource "aws_lb" "alb_atlantis" {
  name               = "alb_atlantis"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.public_subnet_id

  enable_deletion_protection = true

  tags = {Name = "alb_atlantis"}
}