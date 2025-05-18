provider "aws" {
  region = var.apigw.region # Change as needed
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda_logs"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name    = "tf_my_lambda_function"
  runtime          = "python3.10" # Change as needed
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
  publish          = true
}

resource "aws_api_gateway_rest_api" "my_api" {
  name        = "MyAPI"
  description = "API Gateway with Lambda Proxy"
}

resource "aws_api_gateway_resource" "start" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "start"
}

resource "aws_api_gateway_method" "start_post" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.start.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_start" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.start.id
  http_method             = aws_api_gateway_method.start_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.my_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "my_api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_start]
  rest_api_id = aws_api_gateway_rest_api.my_api.id

  # The timestamp forces redeployment everytime even there are no changes
  # triggers = {
  #   redeployment = timestamp()
  # }

  # The use of .version(publish=true) avoids the unnecessary redeployment
  triggers = {
    my_lambda = aws_lambda_function.my_lambda.version
  }

  lifecycle {
    create_before_destroy = true # Makes sure new deployments are created before old ones are deleted
  }
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  deployment_id = aws_api_gateway_deployment.my_api_deployment.id
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/POST/start"
}

output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.my_api.id}.execute-api.${var.apigw.region}.amazonaws.com/prod/start"
}
