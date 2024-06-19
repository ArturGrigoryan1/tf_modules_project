resource "aws_lb" "application_load_balancer" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags   = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name        = var.tg_name
  target_type = "ip"
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id

  health_check {
    enabled             = var.tg_hch_enabled
    interval            = var.tg_hch_interval
    path                = var.tg_hch_path
    timeout             = var.tg_hch_timeout
    matcher             = var.tg_hch_matcher
    healthy_threshold   = var.tg_hch_healthy_threshold
    unhealthy_threshold = var.tg_hch_unhealthy_threshold
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}














