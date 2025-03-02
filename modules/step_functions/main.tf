provider "aws" {
  region = "us-east-1" # Change as needed
}

resource "aws_iam_role" "step_functions_role" {
  name = "StepFunctionsExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["states.amazonaws.com", "ecs-tasks.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "step_functions_ecs" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "events" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "echo_task" {
  family                   = "echo_task"
  network_mode             = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.step_functions_role.arn

  container_definitions = jsonencode([
    {
      name      = "echo_container",
      image     = "busybox",
      command   = ["echo", "hello world"],
      essential = true
    }
  ])
}

resource "aws_sfn_state_machine" "ecs_fargate_sfn" {
  name     = "EcsFargateStateMachine"
  role_arn = aws_iam_role.step_functions_role.arn

  definition = jsonencode({
    Comment = "State machine to run ECS Fargate task",
    StartAt = "RunTask",
    States = {
      RunTask = {
        Type     = "Task",
        Resource = "arn:aws:states:::ecs:runTask.sync",
        Parameters = {
          Cluster        = aws_ecs_cluster.my_cluster.id,
          TaskDefinition = aws_ecs_task_definition.echo_task.arn,
          LaunchType     = "FARGATE",
          NetworkConfiguration = {
            AwsvpcConfiguration = {
              Subnets         = ["subnet-07abe4f6ce40c013b"], # Change to your subnet IDs
              AssignPublicIp = "ENABLED"
            }
          }
        },
        End = true
      }
    }
  })
}
