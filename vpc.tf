resource "aws_subnet" "private_subnet" {
  vpc_id                  = "10.0.0.0/16"
  cidr_block              = "10.0.1.252/24"
  availability_zone       = "ap-south-1a" # Modify based on availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}
