import json
import requests
import os
import base64

def lambda_handler(event, context):
    try:
        # Get subnet ID from Lambda environment variable (from Terraform)
        subnet_id = os.getenv('SUBNET_ID', 'default-subnet-id')

        # Define payload with dynamic values
        payload = {
            "subnet id": subnet_id,
            "name": "Snehal laxman Pawar",
            "email": "snehallpawar11@gmail.com"
        }

        # API endpoint
        api_url = "https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data"

        # Headers with authentication
        headers = {
            "X-Siemens-Auth": "test"
        }

        # Send HTTP POST request
        response = requests.post(api_url, json=payload, headers=headers)

        # Log response
        print("API Response:", response.text)

        # Encode response in base64
        encoded_response = base64.b64encode(response.text.encode()).decode()

        # Return formatted response
        return {
            "StatusCode": response.status_code,
            "LogResult": encoded_response,
            "ExecutedVersion": context.function_version
        }

    except Exception as e:
        print("Error:", str(e))
        return {
            "StatusCode": 500,
            "Error": str(e)
        }