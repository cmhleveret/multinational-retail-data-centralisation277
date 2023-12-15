import yaml
from sqlalchemy import create_engine, inspect

class DatabaseConnector():
    def __init__(self):
        with open('db_creds.yaml', 'r') as file:
            self.db_creds = yaml.safe_load(file)
        print(self.db_creds['RDS_USER'])

    def init_db_engine(self):
        self.engine = create_engine(f"{self.db_creds['RDS_DATABASE_TYPE']}+{self.db_creds['RDS_API']}://{self.db_creds['RDS_USER']}:{self.db_creds['RDS_PASSWORD']}@{self.db_creds['RDS_HOST']}:{self.db_creds['RDS_PORT']}/{self.db_creds['RDS_DATABASE']}")
        return self.engine
    
    def list_db_tables(self):
        self.engine.execution_options(isolation_level='AUTOCOMMIT').connect()
        inspector = inspect(self.engine)
        print(inspector.get_table_names())
        
        
# engine = create_engine(f"{DATABASE_TYPE}+{DBAPI}://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}")

db = DatabaseConnector()
db.init_db_engine()
db.list_db_tables()