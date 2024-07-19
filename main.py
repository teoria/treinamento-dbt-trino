# pip install trino

from trino.dbapi import connect
import pandas as pd

conn = connect(
    host="localhost",
    port=8080,
    user="userpython", 
)
cur = conn.cursor()
# cur.execute("SELECT *, 'from postgres' as source_postgres FROM postgresql.dbt_dev.customers")
 
# print(cur.fetchone() ) 
 

# cur.execute("SELECT *, 'from lake' as source_lake FROM iceberg.jaffle_shop.titanic")
# print(cur.fetchone() ) 

sql = """ 
with 
postgres_users as (
    SELECT *, 'from postgres' as source_postgres FROM postgresql.dbt_dev.customers
)

, lake_users as(
    SELECT *, 'from lake' as source_lake FROM iceberg.jaffle_shop.titanic
) 

select * from postgres_users
inner join lake_users on postgres_users.customer_id = lake_users.PassengerId
--where postgres_users.customer_id = 1
 
"""
cur.execute(sql)
df = pd.DataFrame(cur.fetchall()) 
print("JOIN result")
print(
    df
)