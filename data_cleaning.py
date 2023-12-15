from data_extraction import DataExtractor
import pandas as pd

class DataCleaning():
    def __init__(self):
        print("DataCleaning init")
                  
    def clean_user_data(self, table_name):
        df = DataExtractor().read_rds_table(table_name)
        #remove null values
        df.dropna(axis=0, inplace=True)
        # refomat phone numbers
        df['phone_number'] = df['phone_number'].replace({r'\+44': '0', r'\(': '', r'\)': '', r'-': '', r' ': ''}, regex=True)
        
        print(df)
        return
          
# You will need clean the user data, look out for NULL values, errors with dates, incorrectly typed values and rows filled with the wrong information.

DataCleaning().clean_user_data('legacy_users')