resource "aws_subnet" "public" {
  vpc_id = data.aws_vpc.vpc.id
   cidr_block = "10.0.3.0/24"
}

resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.3.0/24"
    gateway_id = data.aws_nat_gateway.nat
  }

}

resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/hello-python.zip"
function_name                  = "Lambda_Function"
role                           = data.aws_iam_role.lamda
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
}
