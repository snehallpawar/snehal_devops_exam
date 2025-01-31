import requests
import json

def lambda(event, context):
    url = '/candidate-email_serverless_lambda_stage/data'
    payload = {
      "subnet_id": "aws_subnet.private.id",
      "name": "Snehal Pawar",
      "email": "snehallpawar11@gmail.com"
    }

    headers = {
      'X-Siemens-Auth': 'test'
    }

    try:
        conn = http.client.HTTPSConnection("ij92qpvpma.execute-api.eu-west-1.amazonaws.com")
        conn.request("POST", url, json.dumps(payload), headers=headers)
        response = conn.getresponse()
        result = {
            "StatusCode": response.status,
            "LogResult": base64.b64encode(response.read()).decode('utf-8'),
            "ExecutedVersion": "$LATEST"
        }
        conn.close()
    except Exception as e:
        result = {
            "StatusCode": 500,
            "LogResult": str(e),
            "ExecutedVersion": "$LATEST"
        }

    return result
