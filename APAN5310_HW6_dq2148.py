# -- APAN 5310: SQL & RELATIONAL DATABASES

#   -------------------------------------------------------------------------
#   --                                                                     --
#   --                            HONOR CODE                               --
#   --                                                                     --
#   --  I affirm that I will not plagiarize, use unauthorized materials,   --
#   --  or give or receive illegitimate help on assignments, papers, or    --
#   --  examinations. I will also uphold equity and honesty in the         --
#   --  evaluation of my work and the work of others. I do so to sustain   --
#   --  a community built around this Code of Honor.                       --
#   --                                                                     --
#   -------------------------------------------------------------------------


#     You are responsible for submitting your own, original work. We are
#     obligated to report incidents of academic dishonesty as per the
#     Student Conduct and Community Standards.


# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------


# -- HOMEWORK ASSIGNMENT 6


#   NOTES:
#
#     - Type your code between the START and END tags. Code should cover all
#       questions. Do not alter this template file in any way other than
#       adding your answers. Do not delete the START/END tags. The file you
#       submit will be validated before grading and will not be graded if it
#       fails validation due to any alteration of the commented sections.
#
#     - Our course is using PostgreSQL. We grade your assignments in PostgreSQL.
#       You risk losing points if you prepare your SQL queries for a different
#       database system (MySQL, MS SQL Server, Oracle, etc).
#
#     - Make sure you test each one of your answers. If a query returns an error
#       it will earn no points.
#
#     - In your CREATE TABLE statements you must provide data types AND
#       primary/foreign keys (if applicable).
#
#     - You may expand your answers in as many lines as you find appropriate
#       between the START/END tags.
#


# -----------------------------------------------------------------------------


#
#  NOTE: Provide the script that covers all questions between the START/END tags
#        at the end of the file. Separate START/END tags for each question.
#        Add comments to explain each step.
#
#
#  QUESTION 1 (5 points)
#  ---------------------
#  For this assignment we will use a fictional dataset of customer transactions
#  of a pharmacy. The dataset provides information on customer purchases of
#  one or two drugs at different quantities. Download the dataset from the
#  assignment page.
#
#  You will notice that there can be multiple transactions per customer, each
#  one recorded on a separate row.
#
#  Design an appropriate 3NF relational schema. Then, create a new database
#  called "abc_pharmacy" in pgAdmin. Finally, provide the Python code that
#  connects to the new database and creates all necessary tables as per the 3NF
#  relational schema you designed (Note: you should create more than one table).
#
#  NOTE: You should use pgAdmin ONLY to create the database. All other actions
#        must be performed in your Python code. No points if the database
#        tables are created in pgAdmin and not with Python code.

# -- START PYTHON CODE --
import psycopg2
import pandas as pd
from sqlalchemy import create_engine

# Pass the connection string to a variable, conn_url
conn_url = 'postgresql://postgres:123@localhost/abc_pharmacy'
# Create an engine that connects to PostgreSQL server
engine = create_engine(conn_url)
# Establish a connection
connection = engine.connect()

stmt = """  
    CREATE TABLE customers (
        customer_id    integer,
        first_name     varchar(50) NOT NULL,
        last_name      varchar(50) NOT NULL,
        email          varchar(50),
        cell_phones    varchar(20),
        home_phones    varchar(20),
        PRIMARY KEY (customer_id)
    );
    
    CREATE TABLE drugs (
        drug_id       integer NOT NULL,
        drug_name     varchar(200) NOT NULL,
        PRIMARY KEY (drug_id)
    );

    CREATE TABLE drug_company (
        drug_company_id      integer,
        drug_company_name    varchar(200),
        PRIMARY KEY (drug_company_id)
    );
    

    CREATE TABLE purchases (
        customer_id          integer,
        purchase_timestamp   timestamp,
        drug_company_id      integer,
        drug_id              integer,
        quantity             integer,
        price                numeric(5,2),
        PRIMARY KEY (customer_id,drug_id,drug_company_id),
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
        FOREIGN KEY (drug_id) REFERENCES drugs(drug_id),
        FOREIGN KEY (drug_company_id) REFERENCES drug_company(drug_company_id)
    );
"""
# Execute the statement to create tables
connection.execute(stmt)


# -- END PYTHON CODE --

# -----------------------------------------------------------------------------
#
#  QUESTION 2 (15 points)
#  ---------------------
#  Provide the Python code that populates the database with the data from the
#  provided "APAN5310_HW6_DATA.csv" file. You can download the dataset
#  from the assignment page. It is anticipated that you will perform several steps
#  of data processing in Python in order to extract, transform and load all data from
#  the file to the database tables. Manual transformations in a spreadsheet, or
#  similar, are not acceptable, all work must be done in Python. Make sure your code
#  has no errors, no partial credit for code that returns errors. When grading,
#  we will run your script and test your work with sample SQL scripts on the
#  database that will be created and populated.
#

# -- START PYTHON CODE --

#CREATE TABLE customers
df = pd.read_csv('APAN5310_HW6_DATA.csv')
df.insert(0, 'customer_id', range(1, 1 + len(df)))
#create a column named c and split the number into cell and home phones
df['c'] = df['cell_and_home_phones'].astype(str)
df.cell_and_home_phones.str.split(expand=True,)
df['cell_phones'] = df['c'].str[0:12]
df['home_phones'] = df['c'].str[13:]
#delete the c column and cell_and_home_phones column
df.drop('c',axis = 1, inplace=True)
df.drop('cell_and_home_phones',axis = 1, inplace=True)
customers_df = df[['customer_id','first_name','last_name','email','cell_phones','home_phones']]
#push data to database
customers_df.to_sql(name='customers',con=engine, if_exists='append', index=False)


#CREATE TABLE drugs
#combine 2 drug_name columns and drop null values
drugs_df=pd.DataFrame(pd.concat([df['drug_name_1'],df['drug_name_2']]).drop_duplicates(),columns=['drug_name']).dropna(axis=0)
drugs_df.insert(0,'drug_id',range(1,1+len(drugs_df)))
#push data to database
drugs_df.to_sql(name='drugs', con=engine, if_exists='append', index=False)


#CREATE TABLE drug_company
drug_company_df=pd.DataFrame(pd.concat([df['drug_company_1'],df['drug_company_2']]).unique(),columns=['drug_company_name'])
drug_company_df[['drug_company_name']] = drug_company_df[['drug_company_name']].dropna()
drug_company_df.insert(0,'drug_company_id',range(1,1+len(drug_company_df)))
#push data to database
drug_company_df.to_sql(name='drug_company', con=engine, if_exists='append', index=False)


#CREATE TABLE purchases
#create dataframe for two drug transactions
df1=pd.DataFrame(df[['customer_id','first_name', 'last_name','drug_company_1', 'drug_name_1', 'quantity_1', 'price_1','purchase_timestamp']])
df1.columns=[ 'customer_id','first_name', 'last_name','drug_company', 'drug_name', 'quantity', 'price','purchase_timestamp']
df2=pd.DataFrame(df[['customer_id','first_name', 'last_name','drug_company_2', 'drug_name_2', 'quantity_2', 'price_2','purchase_timestamp']])
df2.columns=['customer_id','first_name', 'last_name','drug_company', 'drug_name', 'quantity', 'price','purchase_timestamp']
#combine two transactions into one
df3=pd.concat([df1,df2],ignore_index=True).dropna(axis=0)
df3['price']=df3['price'].str.split('$',expand=True)[1]
#insert drug_company_id and drug_id columns
drug_company_id_list = [drug_company_df.drug_company_id[drug_company_df.drug_company_name == i].values[0] for i in df3.drug_company]
df3.insert(3, 'drug_company_id', drug_company_id_list)
drug_id_list = [drugs_df.drug_id[drugs_df.drug_name == i].values[0] for i in df3.drug_name]
df3.insert(5, 'drug_id', drug_id_list)
#extract data from df to form a purchase_df
purchases_df = df3[['customer_id','drug_company_id','drug_id','quantity','price','purchase_timestamp']]
#push data to database
purchases_df.to_sql(name='purchases', con=engine, if_exists='append', index=False)



# -- END PYTHON CODE --

# -----------------------------------------------------------------------------
#
#  QUESTION 3 (2 points)
#  ---------------------
#  Write the Python code that queries the "abc_pharmacy" database and returns
#  the customer name(s) and total purchase cost of the top 3 most expensive
#  transactions.
#
#  Type the actual result as part of your answer below, as a comment.
#

# -- START PYTHON CODE --

stmt1 = """
SELECT P.customer_id, C.first_name, C.last_name, SUM(P.price*P.quantity) AS total_purchase
FROM purchases AS P LEFT JOIN customers AS C 
ON P.customer_id = C.customer_id
GROUP BY P.customer_id, C.first_name, C.last_name
ORDER BY total_purchase DESC
LIMIT 3
"""
results = connection.execute(stmt1).fetchall()
column_names = results[0].keys()
top_3_transactions = pd.DataFrame(results, columns = column_names)
top_3_transactions

# -- END PYTHON CODE --

# -----------------------------------------------------------------------------
#
#  QUESTION 4 (5 points)
#  ---------------------
#  Write the Python code that queries the "abc_pharmacy" database and creates a
#  histogram of drug prices (price on the x-axis, frequency on the
#  y-axis). The figure must have proper axis titles, title and legend.
#
#  Result should be one figure, do not produce separate figures.
#

# -- START PYTHON CODE --

import numpy as np
from matplotlib import pyplot as plt
stmt2 = """
SELECT price
FROM purchases
ORDER BY price
"""
results = connection.execute(stmt2).fetchall()
column_names_stmt2 = results[0].keys()
histogram = pd.DataFrame(results, columns=column_names_stmt2)

plt.figure(figsize=(10,8))
plt.hist(histogram['price'],bins=20,facecolor='grey',edgecolor = 'white')
plt.xlabel('drug_price')
plt.ylabel('frequency')
plt.title('histogram of drug prices')
plt.show()

# -- END PYTHON CODE --

# -----------------------------------------------------------------------------
