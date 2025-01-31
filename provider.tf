terraform {
  backend "s3" {
    bucket = "467.devops.candidate.exam"
    key    = "snehal.pawar"  
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
# Add your S3 backend configuration here
