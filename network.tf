terraform {
  backend "s3" {
    bucket = "467.devops.candidate.exam"
    region = "ap-south-1"
    key    = "<Your First Name>.<Your Last Name>"
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Data sources for existing resources
data "aws_nat_gateway" "nat" {
  id = "nat-0a34a8efd5e420945"
}

data "aws_vpc" "vpc" {
  id = "vpc-06b326e20d7db55f9"
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"  # Choose your desired CIDR
  availability_zone       = "ap-south-1a"  # You can choose the availability zone
  map_public_ip_on_launch = false
}

# Routing Table
resource "aws_route_table" "private_route_table" {
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Lambda Security Group
resource "aws_security_group" "lambda_security_group" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "lambda_sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Lambda Function
resource "aws_lambda_function" "lambda" {
  function_name = "devops_lambda_function"
  role          = data.aws_iam_role.lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"  # Choose appropriate runtime for your Lambda function
  filename      = "lambda_function.zip"  # Ensure you have zipped your Lambda code
  source_code_hash = filebase64sha256("lambda_function.zip")
  
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_security_group.id]
  }
}
