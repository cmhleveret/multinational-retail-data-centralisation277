from data_extraction import DataExtractor
import pandas as pd

class DataCleaning():
    def __init__(self):
        print("DataCleaning init")
                  
    def clean_user_data(self, df):
        # df = DataExtractor().read_rds_table(table_name)
        #remove null values
        # refomat phone numbers
        df['phone_number'] = df['phone_number'].replace({r'\+44': '0', 
                                                         r'\(': '', 
                                                         r'\)': '', 
                                                         r'-': '', 
                                                         r' ': '',
                                                         r'\.': ''}, regex=True)
        #remove 00 at start of numbers afer +44 removed
        df['phone_number'] = df['phone_number'].replace({r'^00': '0'}, regex=True)
        #remove phone numbers with less than 10 digits
        df = df[df['phone_number'].str.len() >= 10]
        #remove UK phone numbers with less than 11 digits
        condition = (df['country_code'].str.lower() == 'gb') & (df['phone_number'].str.len() < 11)
        #the ~ operator negates the condition,
        df = df[~condition]

        # fix datess
        df['join_date'] = pd.to_datetime(df['join_date'], format='%Y-%m-%d', errors='coerce')
        df['date_of_birth'] = pd.to_datetime(df['date_of_birth'], format='%Y-%m-%d', errors='coerce')

        # fix types
        df = df.astype({'first_name': str, 'last_name': str, 'company': str})
        # df = df['date_of_birth'] = pd.to_datetime(df['date_of_birth'], format='%Y %m %d')

        df.dropna(axis=0, inplace=True)
        print(df.dtypes)
        print(df.head)
        return df
          
# You will need clean the user data, 
    # look out for NULL values, 
    # errors with dates, 
    # incorrectly typed values and rows filled with the wrong information.

# DataCleaning().clean_user_data('legacy_users')