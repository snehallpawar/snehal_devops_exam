resource "aws_subnet" "private_subnet" {
  vpc_id                  = "vpc-06b326e20d7db55f9"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-1a" # Modify based on availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}
