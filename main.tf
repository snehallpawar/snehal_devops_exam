resource "aws_subnet" "public" {
  vpc_id = "vpc-06b326e20d7db55f9"
   cidr_block = "10.0.3.0/24"
}

resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.3.0/24"
    gateway_id = "nat-0a34a8efd5e420945"
  }

}

resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "lambda_funstion.py"
function_name                  = "Lambda_Function"
role                           = data.aws_iam_role.lambda
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
}
