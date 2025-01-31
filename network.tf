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
  cidr_block              = "10.0.1.0/24"  # Replace with an available CIDR block
  availability_zone       = "ap-south-1a"  # Choose the availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Define the NAT Gateway (this will allow outbound traffic for the private subnet)
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "NAT-Gateway"
  }
}

# Define the Elastic IP for the NAT Gateway
resource "aws_eip" "nat_ip" {
  vpc = true
}

# Define the Route Table for the Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = vpc-06b326e20d7db55f9

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = nat-0a34a8efd5e420945  # Use the NAT Gateway ID
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Define Security Group for the Lambda function inside VPC
resource "aws_security_group" "lambda_sg" {
  name        = "DevOps-Candidate-Lambda-Role"
  description = "Security group for Lambda function"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the Private Subnet ID (This will be used dynamically in Lambda configuration)
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
