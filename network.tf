resource "aws_subnet" "private_subnet" {
  vpc_id                  = "vpc-06b326e20d7db55f9"  # Replace with your VPC ID
  cidr_block              = "10.0.1.0/24"  # Replace with an available CIDR block
  availability_zone       = "ap-south-1a"  # Choose the availability zone
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
