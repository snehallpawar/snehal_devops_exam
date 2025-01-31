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
    
        stage('Invoke Lambda') {
            steps {
                script {
                    sh 'aws lambda invoke --function-name lambda.py --log-type Tail output.txt'
                }
            }
        }
    }
}
