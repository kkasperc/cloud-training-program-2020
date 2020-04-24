resource "aws_lb" "alb-atlantis" {
  name               = "alb-atlantis"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = [var.public_subnet_id,var.public1_subnet_id]

  enable_deletion_protection = true

  tags = {Name = "alb-atlantis"}
}