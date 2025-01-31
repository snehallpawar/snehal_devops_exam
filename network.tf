resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Private Subnet Resource
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"  # Modify based on your availability zone
  map_public_ip_on_launch = false  # Ensures it’s a private subnet
  tags = {
    Name = "private-subnet"
  }
}

# Output the Private Subnet ID
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
