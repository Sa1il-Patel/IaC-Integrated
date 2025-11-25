resource "aws_ecs_cluster" "cluster" {
name = "${var.app_name}-cluster"
}


# Minimal task definition / service with FARGATE
resource "aws_ecs_task_definition" "task" {
family = "${var.app_name}-task"
network_mode = "awsvpc"
requires_compatibilities = ["FARGATE"]
cpu = "256"
memory = "512"
execution_role_arn = aws_iam_role.ecs_task_exec.arn


container_definitions = jsonencode([
{
name = "container"
image = "REPLACE_ME_WITH_IMAGE"
essential = true
portMappings = [{ containerPort = 8080, hostPort = 8080 }]
logConfiguration = {
logDriver = "awslogs"
options = {
awslogs-group = "/ecs/${var.app_name}"
awslogs-region = var.aws_region
awslogs-stream-prefix = "ecs"
}
}
}
])
}


resource "aws_iam_role" "ecs_task_exec" {
name = "${var.app_name}-ecs-exec-role"
assume_role_policy = jsonencode({
Version = "2012-10-17",
Statement = [{ Effect = "Allow", Principal = { Service = "ecs-tasks.amazonaws.com" }, Action
