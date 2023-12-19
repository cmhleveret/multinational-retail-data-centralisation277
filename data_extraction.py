from database_utils import DatabaseConnector
from sqlalchemy import create_engine, inspect, text
import pandas as pd
import tabula
import requests


class DataExtractor():
    def __init__(self):
        self.db = DatabaseConnector()
        print("dataExtractor init")

    def read_rds_table(self, table_name):
        engine = self.db.init_db_engine()
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
                
       
# DataExtractor().read_rds_table('legacy_users')
# print("db extraction")
    
