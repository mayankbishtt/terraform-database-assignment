resource "aws_security_group" "alb_sg" {

  name        = "alb-security-group"
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "alb-security-group"

  }

}

resource "aws_lb" "alb" {

  name               = "hotel-app-alb"

  internal           = false

  load_balancer_type = "application"

  security_groups = [

    aws_security_group.alb_sg.id

  ]

  subnets = var.public_subnet_ids

  tags = {

    Name = "hotel-app-alb"

  }

}

resource "aws_lb_target_group" "ecs_target_group" {

  name = "ecs-target-group"

  port = 80

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {

    path = "/"

    protocol = "HTTP"

  }

}

resource "aws_lb_listener" "http_listener" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.ecs_target_group.arn

  }

}

