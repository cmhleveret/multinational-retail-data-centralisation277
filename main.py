from data_cleaning import DataCleaning
from data_extraction import DataExtractor
from database_utils import DatabaseConnector
       
initial_data = DataExtractor().read_rds_table('legacy_users')
print(initial_data)

clean_data = DataCleaning().clean_user_data(initial_data)
print(clean_data)

DatabaseConnector().upload_to_db(clean_data, 'dim_users')