import yaml
from sqlalchemy import create_engine, inspect
# from data_cleaning import DataCleaning

class DatabaseConnector():
    def __init__(self):
        with open('db_creds.yaml', 'r') as file:
            self.db_creds = yaml.safe_load(file)
        with open('local_db_creds.yaml', 'r') as file:
            self.local_db_creds = yaml.safe_load(file)

        print('Database Connector init')

    def init_db_engine(self):
        self.engine = create_engine(f"{self.db_creds['RDS_DATABASE_TYPE']}+{self.db_creds['RDS_API']}://{self.db_creds['RDS_USER']}:{self.db_creds['RDS_PASSWORD']}@{self.db_creds['RDS_HOST']}:{self.db_creds['RDS_PORT']}/{self.db_creds['RDS_DATABASE']}")
        return self.engine
    
    def list_db_tables(self):
        self.engine.execution_options(isolation_level='AUTOCOMMIT').connect()
        inspector = inspect(self.engine)
        return inspector.get_table_names()
    
    def upload_to_db(self, df, table_name):
        engine = create_engine(f"{self.local_db_creds['RDS_DATABASE_TYPE']}+{self.local_db_creds['RDS_API']}://{self.local_db_creds['RDS_USER']}:{self.local_db_creds['RDS_PASSWORD']}@{self.local_db_creds['RDS_HOST']}:{self.local_db_creds['RDS_PORT']}/{self.local_db_creds['RDS_DATABASE']}")
        df.to_sql(f'{table_name}', engine, if_exists='replace')
        #Once extracted and cleaned use the upload_to_db method to store the data in your sales_data database in a table named dim_users.
        return

        
        
# engine = create_engine(f"{DATABASE_TYPE}+{DBAPI}://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}")

# db = DatabaseConnector()
# db.init_db_engine()
# db.list_db_tables()

# ['legacy_store_details', 'legacy_users', 'orders_table']
    

# df = DataCleaning().clean_user_data('legacy_users')

# DatabaseConnector().upload_to_db(df, 'dim_users')