import json
import boto3 # pip install boto3
from botocore.exceptions import ClientError

def get_db_config():
 
    # This is where our DB password lives in AWS
    secret_name = "printos/db/credentials"
    region_name = "us-east-2"
    
    try:
        # Connect to AWS Secrets Manager
        client = boto3.client('secretsmanager', region_name=region_name)
        
        # Fetch the secret (contains all our DB info)
        response = client.get_secret_value(SecretId=secret_name)
        
        # Parse the JSON response into a Python dict
        secret = json.loads(response['SecretString'])
        
        # Just a quick confirmation we're connecting to the right place
        print(f"Connected to: {secret.get('host', 'unknown')}")
        
        # Return a clean dict with all the connection info
        # AWS stores it as 'username' but pymysql wants 'user'
        return {
            'host': secret['host'],
            'user': secret['username'],  # Note: converting 'username' to 'user'
            'password': secret['password'],
            'database': secret.get('dbname', 'printosdb'),  # changed printosdabase to printosdb
            'port': int(secret.get('port', 3306))  # MySQL default port is 3306
        }
    except ClientError as e:
        # If AWS can't find the secret or we don't have permissions, let us know
        print(f"Error getting secret: {e}")
        raise  # Re-throw the error so the program stops