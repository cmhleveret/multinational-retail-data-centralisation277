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

        # if (combined_df.iloc[:, 1].notna().all()):
        #     combined_df.dropna(axis=1, inplace=True)

        # if (combined_df['card_number'].notna().all()):
        #     combined_df.dropna(axis=1, inplace=True)
        # Drop rows where 'card_number' is null
        # combined_df.dropna(subset=['card_number'], inplace=True)
        # combined_df.dropna(subset=['expiry_date'], inplace=True)
        combined_df = combined_df.dropna(subset=[combined_df.columns[1]])
        combined_df = combined_df.dropna(axis=1, how='all')
        # 
        return combined_df
          
# You will need clean the user data, 
    # look out for NULL values, 
    # errors with dates, 
    # incorrectly typed values and rows filled with the wrong information.

# DataCleaning().clean_user_data('legacy_users')