resource "aws_lambda_function" "lambda_function" {
  function_name = "my-lambda-function"
  role          = data.aws_iam_role.lambda.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 15
  memory_size   = 128

  s3_bucket = "467.devops.candidate.exam"
  s3_key    = "lambda/lambda_function.zip"

  vpc_config {
    subnet_ids          = [aws_subnet.private_subnet.id]
    security_group_ids  = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = {
      SUBNET_ID = aws_subnet.private_subnet.id
      FULL_NAME = "Snehal Pawar"
      EMAIL     = "snehallpawar11@gmail.com"
    }
  }

  depends_on = [aws_iam_role_policy.lambda_policy]
}
