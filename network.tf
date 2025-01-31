resource "aws_subnet" "private_subnet" {
  vpc_id     = "vpc-06b326e20d7db55f9"
  cidr_block = "10.0.11.0/24"  # Use an available block, e.g., 10.0.X.0/24
  availability_zone = "ap-south-1a"  # Choose an AZ
  map_public_ip_on_launch = false  # Since it’s a private subnet

  tags = {
    Name = "Private Subnet"
  }
}
