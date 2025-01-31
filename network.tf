# Define the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Define the Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = vpc-06b326e20d7db55f9
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"  # Adjust based on your region
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Define the Security Group for Lambda (to access the internet or other resources if needed)
resource "aws_security_group" "lambda_sg" {
  vpc_id = vpc-06b326e20d7db55f9
  # Adjust the rules as needed
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
}

# Define the IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda-vpc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the VPC Access Policy to Lambda IAM role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda-vpc-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  roles      = [aws_iam_role.lambda_role.name]
}

# Define the Lambda function (Python)
resource "aws_lambda_function" "lambda_function" {
  function_name = "RemoteAPIFunction"

  # Lambda zip file (make sure to replace this with your actual zip file)
  filename      = "function.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      SUBNET_ID = aws_subnet.private_subnet.id  # Subnet ID dynamically fetched
      NAME      = "Snehal.pawar"
      EMAIL     = "snehallpawar11@gmail.com"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  # Define the timeout for the function
  timeout = 30
}

# Output the Lambda Function ARN
output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
}
