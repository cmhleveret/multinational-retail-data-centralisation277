# Project Title
Data Extraction Tutorial

## Table of Contents
- [Project Description](#project-description)
- [Installation](#installation)
- [Usage](#usage)
- [File Structure](#file-structure)
- [License](#license)

## Project Description
This project is focused on data extraction, cleaning, and database management. It includes several Python classes and methods for processing and manipulating data from various sources, including RDS tables, PDF files, APIs, and AWS S3 buckets. The aim is to provide efficient and effective solutions for data handling tasks, such as cleaning user data, converting product weights, and managing database operations. This project has been a learning journey in understanding the intricacies of data handling in Python, including working with pandas, SQLAlchemy, requests, and other libraries.

## Installation
To get started with this project, clone the repository and install the required dependencies:
```bash
git clone ThisRepo
cd ThisRepo
pip install -r requirements.txt
```
## Usage
The project can be utilized for various data handling tasks:

- **Data Extraction**: Extracting data from different sources.
- **Data Cleaning**: Cleaning and formatting data for analysis.
- **Database Operations**: Uploading and managing data in databases.

Example usage:

```python
from data_cleaning import DataCleaning
from data_extraction import DataExtractor
from database_utils import DatabaseConnector
```

## Database Connectivity

### `DatabaseConnector` Class

The `DatabaseConnector` class, defined in `database_utils.py`, is responsible for handling database connections and operations. It uses `yaml` to load database credentials and `sqlalchemy` to establish connections and perform database operations.

Key functionalities include:
- **Initializing Database Connection**: Establishes a connection to the database using credentials stored in `db_creds.yaml` and `local_db_creds.yaml`.
- **Listing Database Tables**: The `list_db_tables` method retrieves and lists all tables in the connected database.
- **Uploading Data to Database**: The `upload_to_db` method allows uploading a DataFrame to a specified table in the database, replacing the table if it already exists.

Example usage:
```python
from database_utils import DatabaseConnector
from data_cleaning import DataCleaning

# Initialize database connector
db = DatabaseConnector()

# List available tables in the database
tables = db.list_db_tables()
print(tables)

# Example of using DataCleaning and uploading cleaned data
# cleaned_data = DataCleaning().clean_user_data(your_dataframe)
# db.upload_to_db(cleaned_data, 'target_table_name')
```

## Data Extraction

### `DataExtractor` Class

The `DataExtractor` class, part of `data_extraction.py`, manages the extraction of data from various sources. It leverages the `DatabaseConnector` for database operations and other libraries for handling different data formats.

Key functionalities include:
- **Reading from RDS Tables**: The `read_rds_table` method connects to an RDS database to retrieve data from a specified table.
- **Extracting PDF Data**: `retrieve_pdf_data` extracts data from a PDF file using the link provided.
- **API Data Retrieval**: Methods like `list_number_of_stores` and `retrieve_stores_data` handle data extraction from RESTful APIs.
- **AWS S3 Data Extraction**: The `extract_from_s3` method pulls data from an AWS S3 bucket.
- **JSON Data Extraction**: `extract_from_json` retrieves data from a JSON file via a provided link.

Example usage:
```python
from data_extraction import DataExtractor

extractor = DataExtractor()

# Example of reading data from RDS
rds_data = extractor.read_rds_table('table_name')

# Example of extracting data from a PDF file
pdf_data = extractor.retrieve_pdf_data('http://link_to_pdf')

# Example of extracting data from an S3 bucket
s3_data = extractor.extract_from_s3()
```
## Data Cleaning

### `DataCleaning` Class

The `DataCleaning` class, defined in `data_cleaning.py`, is crucial for preparing and sanitizing data for further analysis and storage. This class includes various methods for cleaning different types of data.

Key functionalities include:
- **Cleaning User Data**: The `clean_user_data` method refines user data, like reformatting phone numbers and handling null values.
- **Cleaning Card Data**: `clean_card_data` processes card-related data, consolidating data frames and removing null values.
- **Cleaning Store Data**: The `clean_store_data` method deals with store-related information, including staff numbers and opening dates.
- **Converting Product Weights**: `convert_product_weights` converts product weight information into a consistent format.
- **Cleaning Products Data**: The `clean_products_data` method standardizes product information.
- **Cleaning Orders Data**: `clean_orders_data` refines order-related data by removing unnecessary columns.
- **Cleaning Date and Time Data**: The `clean_dim_date_times` method standardizes date and time information into a consistent format.

Example usage:
```python
from data_extraction import DataExtractor
from data_cleaning import DataCleaning

# Assuming data extraction is already done
extractor = DataExtractor()
raw_data = extractor.read_rds_table('table_name')

# Initialize data cleaner
cleaner = DataCleaning()

# Clean the extracted data
clean_data = cleaner.clean_user_data(raw_data)
```

## File Structure

- `data_extraction.py`: Contains the `DataExtractor` class for data extraction from various sources.
- `data_cleaning.py`: Houses the `DataCleaning` class for cleaning and preparing data.
- `database_utils.py`: Includes the `DatabaseConnector` class for database connection and operations.
- Additional utility scripts and configuration files.


# SQL 
## Database Schema Modification and Integrity

This project also includes comprehensive steps for modifying database schemas, ensuring data integrity, and establishing relational links between tables. These operations are crucial for maintaining a robust and reliable database structure.

### Schema Modifications

The SQL scripts provided cover a range of schema alterations, including changing column data types, adding new columns, and deleting unnecessary ones. Key modifications include:

- **Altering Column Data Types**: Various tables have their column data types altered to better suit the data they hold. This includes changing columns to types such as `VARCHAR`, `SMALLINT`, `FLOAT`, and `UUID`.
  
- **Dynamic Column Type Alteration**: Some columns are altered based on dynamic criteria, such as setting the column type length to the maximum length of existing data.

- **Data Cleaning and Standardization**: Certain columns are updated for consistency, such as removing specific characters from text fields and converting data into a uniform format.

### Establishing Primary Keys

Primary keys are added to various dimension tables (`dim_*`) to ensure each record can be uniquely identified. This process involves:

- **Checking for Uniqueness and Null Values**: Before adding primary keys, we ensure that the candidate columns contain unique, non-null values.

- **Primary Key Addition**: Primary keys are added to tables like `dim_users`, `dim_store_details`, `dim_products`, `dim_date_times`, and `dim_card_details`.

### Adding Foreign Keys to `orders_table`

Foreign keys are added to the `orders_table` to establish relationships with the dimension tables. This ensures referential integrity and links records across tables. The process involves:

- **Identifying and Handling Non-Existent Values**: Before setting up foreign keys, we identify and resolve any non-existent values in the foreign key columns.

- **Deleting Inconsistent Records**: In some cases, records with non-matching foreign key values are deleted from `orders_table`.

- **Setting Foreign Keys**: Foreign key constraints are added to `orders_table`, linking it to the respective dimension tables based on keys like `card_number`, `date_uuid`, `product_code`, `store_code`, and `user_uuid`.

This section of the project plays a vital role in ensuring the database's integrity and the accuracy of relationships between different data entities.

## License

This project is licensed under the [Your License Name] License. See the LICENSE file for more details.
