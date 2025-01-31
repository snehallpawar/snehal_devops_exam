pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                script{
                    echo "Executing Terraform Init"
                    sh("terraform init")
                }
            }
        }
        stage("TF Validate"){
            steps{
                script{
                    echo "Validating Terraform Code"
                    sh("terraform validate")
                }
            }
        }
        stage("TF Plan"){
            steps{
                script{
                    echo "Executing Terraform Plan"
                    sh("terraform plan -out=plan")
                }
            }
        }
        stage("TF Apply"){
            steps{
                script{
                    echo "Executing Terraform Apply"
                    sh("terraform apply --auto-approve")
                }
                
            }
        }
        stage("Invoke Lambda"){
            steps{
                script{
                    echo "Invoking your AWS Lambda"
                    sh("aws lambda invoke --function-name lambda_fun --log-type Tail response.json")
                }
            }
        }
    }
}




