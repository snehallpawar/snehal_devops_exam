import requests
def lambda_handler(event, context):
  url="https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data"
  response = requests.post(url)
