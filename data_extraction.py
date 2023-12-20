from database_utils import DatabaseConnector
from sqlalchemy import create_engine, inspect, text
import pandas as pd
import tabula
import requests
import boto3
from botocore.exceptions import NoCredentialsError, ClientError
import io

class DataExtractor():
    def __init__(self):
        self.db = DatabaseConnector()
        print("dataExtractor init")

    def read_rds_table(self, table_name):
        engine = self.db.engine
        with engine.connect() as connection:
            result = connection.execute(text(f"SELECT * FROM {table_name}"))
            df = pd.DataFrame(result)
        return df
    
    def retrieve_pdf_data(self, link):
        df = tabula.read_pdf(link, stream=True, pages='all')
        return df
    
    def list_number_of_stores(self, endpoint, header):
        # headers = {'Authorization': key}
        response = requests.get(endpoint, headers=header)
        if response.status_code == 200:
            data = response.json()
            return data['number_stores']
        else:
             # Handle errors or unsuccessful responses here
            return "Error: " + str(response.status_code)
        
    def retrieve_stores_data(self, endpoint, header, number_stores):
        data_frames = []
        for i in range(number_stores):
            try:
                response = requests.get(f'{endpoint}{i}', headers=header)
                if response.status_code == 200:
                    response = response.json()
                    print(f'{i}/{number_stores} loaded')
                    print(response)
                    data_frames.append(pd.DataFrame([response]))
                else:
                    return f"Error: Received response with status code {response.status_code}"

            except requests.exceptions.RequestException as e:
                return f"Request Error: {e}"
            
        combined_df = pd.concat(data_frames, ignore_index=True)
        return combined_df
    
    def extract_from_s3(self):
        try:
            s3 = boto3.client('s3')
            # response = s3.download_file('data-handling-public', 'products.csv', './products.csv')
            response = s3.get_object(Bucket='data-handling-public', Key='products.csv')
            content = response['Body'].read().decode('utf-8')
            data = io.StringIO(content)
            df = pd.read_csv(data)
        except NoCredentialsError:
            print("AWS credentials not found. Please configure your credentials.")

        except ClientError as e:
            if e.response['Error']['Code'] == 'NoSuchBucket':
                print("The specified bucket does not exist.")
            else:
                print("An error occurred:", e)

        
        return df
        
                
       
# DataExtractor().read_rds_table('legacy_users')
# print("db extraction")
    
