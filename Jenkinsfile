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
    
    
        stage('Invoke Lambda') {
            steps {
                script {
                    def invokeResult = sh(script: "aws lambda invoke --function-name my_lambda_function --log-type Tail output.txt", returnStdout: true).trim()
                    echo invokeResult
                }
            }
        }
    }

    
}
