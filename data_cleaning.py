from data_extraction import DataExtractor
import pandas as pd
import numpy as np

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
        ##use .loc to prevent copy errors
        df = df.loc[df['phone_number'].str.len() >= 10]

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
    
    def clean_card_data(self, data):
       #combine list of data anc cover into dataframes
        data_frames = []
        for item in data:
            df = pd.DataFrame(item)  # Convert each dictionary to a DataFrame
            df.dropna(axis=1, inplace=True)
            data_frames.append(df)
        combined_df = pd.concat(data_frames, ignore_index=True) 
        # Drop rows where 'card_number' is null
        combined_df = combined_df.dropna(subset=[combined_df.columns[1]])
        combined_df = combined_df.dropna(axis=1, how='all')
        # 
        return combined_df
    
    def clean_store_data(self, df):
        #drop rows with all null values
        # df.replace('N/A', np.nan, inplace=True)
        # columns_to_check = ['address', 'longitude', 'locality']

        #check staff_numbers - if not a number drop row
        df['staff_numbers'] = pd.to_numeric(df['staff_numbers'], errors='coerce')
        df.dropna(subset=['staff_numbers'], inplace=True)

        #check data time types - remove rows that dont comply
        df['opening_date'] = pd.to_datetime(df['opening_date'], format='%Y-%m-%d', errors='coerce')

        #drop column with all none value (lat)
        df.replace('N/A', np.nan, inplace=True)
        df.dropna(axis=1, how='all', inplace=True)

        #validate continent names
        # valid_continents = ["Europe", "Asia", "Africa", "North America", "South America", "Australia", "Antarctica"]
        # df.loc[~df['continent'].isin(valid_continents), 'continent'] = np.nan
        # or could use fuzzywuzzy?

        #drop rows with n/a - web stores
        # columns_to_check = ['address', 'longitude', 'locality']
        # df.dropna(subset=columns_to_check, how='any', inplace=True)

        #convert date values to dates
        return df
    
    def convert_product_weights(self, df):
        #clean the weight column i.e to lower
        df['weight'] = df['weight'].str.lower()
        df.dropna(axis=0, how='any', inplace=True)
        
        #create new column with weight as float 
        df['weight_kg'] = df['weight'].replace({r'kg': '',
                                                r'g': ''},  
                                                regex=True)
        #drop rows that dont have a number in this column
        # Example regex for floating-point numbers
        regex_expression = r'^\d+(\.\d+)?$'
        df.loc[~df['weight_kg'].str.match(regex_expression), 'weight_kg'] = np.nan 

        df.dropna(axis=0, inplace=True) 
        df = df.astype({'weight_kg': float})

        #convert all values to KG 
        df.loc[~df['weight'].str.endswith('kg'), 'weight_kg'] = df['weight_kg']/1000

        #convert all values to ml 
        df['estimated_vol_ml'] = df['weight_kg'] * 1000

        return df
    
    def clean_products_data(self, df):
        df['date_added'] = pd.to_datetime(df['date_added'], format='%Y-%m-%d', errors='coerce')

        df = df.astype({'product_name': str, 'product_price': str, 'weight': str, 'category': str, 'EAN': str, 'uuid': str,'removed': str, 'product_code': str})
        df.dropna(axis=1, how='all', inplace=True)
        df.dropna(axis=1, how='any', inplace=True)
        return df
    
    def clean_orders_data(self, df):
        df.drop(['first_name', 'last_name', '1', 'level_0'], axis=1, inplace=True)

        if 'level_0' in df.columns:
            df.rename(columns={'level_0': 'level_0_index'}, inplace=True)
        return df
          
