
resource "aws_subnet" "private" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private_table" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_table_assoctation" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_table.id
}


resource "aws_lambda_function" "lambda_function" {
  function_name = "lambda_function"
  role = data.aws_iam_role.lambda.arn
  handler = "lambda_function.lambda"
  runtime = "python3.8"
  filename = "lambda_function(3).zip"
}
