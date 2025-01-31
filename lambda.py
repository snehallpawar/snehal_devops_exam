import json
import os
import requests

def lambda_handler(event, context):
    # Getting environment variables passed from Terraform
    subnet_id = os.getenv('SUBNET_ID')
    full_name = os.getenv('FULL_NAME')
    email = os.getenv('EMAIL')
    
    # Define the API endpoint and headers
    api_url = "https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data"
    headers = {
        "X-Siemens-Auth": "test",
        "Content-Type": "application/json"
    }
    
    # Define the payload
    payload = {
        "subnet_id": aws_subnet.private_subnet,
        "name": "snehal Pawar"
        "email": "snehallpawar11@gmail.com"
    }
    
    # Send the POST request to the API
    try:
        response = requests.post(api_url, headers=headers, json=payload)
        
        # Check if the request was successful
        if response.status_code == 200:
            return {
                'statusCode': 200,
                'body': json.dumps('Successfully invoked the API')
            }
        else:
            return {
                'statusCode': response.status_code,
                'body': json.dumps('Failed to invoke the API')
            }
    
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }
