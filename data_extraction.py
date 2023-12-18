from database_utils import DatabaseConnector
from sqlalchemy import create_engine, inspect, text
import pandas as pd

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
                
       
# DataExtractor().read_rds_table('legacy_users')
# print("db extraction")
    
