resource "aws_security_group" "ecs_sg" {

  name   = "ecs-security-group"
  vpc_id = var.vpc_id

  ingress {

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      var.alb_security_group_id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-security-group"
  }

}

resource "aws_ecs_cluster" "cluster" {

  name = "hotel-cluster"

}

resource "aws_cloudwatch_log_group" "ecs_logs" {

  name = "/ecs/hotel-app"

  retention_in_days = 7

}

resource "aws_ecs_task_definition" "task" {

  family = "hotel-task"

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu = "256"

  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([

    {

      name = "nginx"

      image = "nginx:latest"

      essential = true

      portMappings = [

        {

          containerPort = 80

          hostPort = 80

        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs_logs.name

          awslogs-region = "ap-south-1"

          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])

}

resource "aws_ecs_service" "service" {

  name = "hotel-service"

  cluster = aws_ecs_cluster.cluster.id

  task_definition = aws_ecs_task_definition.task.arn

  desired_count = 2

  launch_type = "FARGATE"

  network_configuration {

    subnets = var.private_subnet_ids

    security_groups = [

      aws_security_group.ecs_sg.id

    ]

    assign_public_ip = false

  }

  load_balancer {

    target_group_arn = var.target_group_arn

    container_name = "nginx"

    container_port = 80

  }

}

