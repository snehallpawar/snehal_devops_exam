resource "aws_subnet" "private_subnet" {
  vpc_id                  = "vpc-06b326e20d7db55f9"  # Replace with your VPC ID
  cidr_block              = "10.0.8.0/24"  # Replace with an available CIDR block
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Define Route Table for the Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = "vpc-06b326e20d7db55f9"  # Replace with your VPC ID

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "nat-0a34a8efd5e420945"  # Replace with your NAT Gateway ID
  }

  tags = {
    Name = "DevOps-Candidate-Lambda-Role"
  }
}
# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Define Security Group for the Lambda function inside VPC
resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = "vpc-06b326e20d7db55f9"  # Replace with your VPC ID

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.8.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["010.0.8.0/24"]
  }
}
