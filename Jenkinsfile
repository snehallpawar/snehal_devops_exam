pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/snehallpawar/snehal_devops_exam.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -force-copy'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
          stage('Invoke Lambda Function') {
            steps {
                script {
                    // Invoke Lambda function using AWS CLI
                    sh 'aws lambda invoke --function-name my-lambda-function output.txt --log-type Tail'
                }
            }
        }

        stage('Base64 Decode Log Result') {
            steps {
                script {
                    // Decode the base64 log result returned by Lambda
                    def result = sh(script: "cat output.txt", returnStdout: true).trim()
                    def decodedResult = sh(script: "echo ${result} | base64 --decode", returnStdout: true).trim()
                    echo "Decoded Log Result: ${decodedResult}"
                }
            }
        }
}
