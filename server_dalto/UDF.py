import mysql.connector
import pandas as pd

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="northwind"
)

square = lambda n : n*n

cursor = conn.cursor()
cursor.execute("SELECT * FROM Products;")  # Consultar la tabla correcta

result = cursor.fetchall()
result_df = pd.DataFrame(result)
print(result_df)

conn.close()
