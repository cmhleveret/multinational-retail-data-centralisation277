from data_cleaning import DataCleaning
from data_extraction import DataExtractor
from database_utils import DatabaseConnector
import pandas as pd

#Task 3  
# initial_data = DataExtractor().read_rds_table('legacy_users')
# print(initial_data)

# clean_data = DataCleaning().clean_user_data(initial_data)
# print(clean_data)

# DatabaseConnector().upload_to_db(clean_data, 'dim_users')

#Task 4
# data = DataExtractor().retrieve_pdf_data("https://data-handling-public.s3.eu-west-1.amazonaws.com/card_details.pdf")
# clean_data = DataCleaning().clean_card_data(data)
# DatabaseConnector().upload_to_db(clean_data, 'dim_card_details')

#Task 5
# header = {'x-api-key' : 'yFBQbwXe9J3sd6zWVAMrK6lcxxr0q1lr2PT6DDMX'}
# endpoint = 'https://aqj7u5id95.execute-api.eu-west-1.amazonaws.com/prod/number_stores'
# number_stores = DataExtractor().list_number_of_stores(endpoint, header)

# endpoint = 'https://aqj7u5id95.execute-api.eu-west-1.amazonaws.com/prod/store_details/'
# store_data = DataExtractor().retrieve_stores_data(endpoint, header, number_stores)
# print(store_data)

# clean_store_data = DataCleaning().clean_store_data(store_data)
# print(clean_store_data)

# DatabaseConnector().upload_to_db(clean_store_data, 'dim_store_details')

#Task 6
# products_df = DataExtractor().extract_from_s3()
# converted_product_weights = DataCleaning().convert_product_weights(products_df)
# print(converted_product_weights.dtypes)

# cleaned_coverted_product_data = DataCleaning().clean_products_data(converted_product_weights)
# print(cleaned_coverted_product_data)
# DatabaseConnector().upload_to_db(cleaned_coverted_product_data, 'dim_products')


#Task 7

#This does not work in my venv?
# tables = DatabaseConnector().list_db_tables()
# print(tables)

# df = DataExtractor().read_rds_table('orders_table')
# print(df)
# cleaned_df = DataCleaning().clean_orders_data(df)
# print(cleaned_df)
# DatabaseConnector().upload_to_db(cleaned_df, 'orders_table')

#Task 8
link = 'https://data-handling-public.s3.eu-west-1.amazonaws.com/date_details.json'
df = DataExtractor().extract_from_json(link)
cleaned_df = DataCleaning().clean_dim_date_times(df)
print(cleaned_df.dtypes)

DatabaseConnector().upload_to_db(cleaned_df, 'dim_date_times')