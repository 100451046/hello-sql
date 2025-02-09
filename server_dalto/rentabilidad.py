import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "1234",
    database = "northwind"
)

#10 PRODUCTOS MAS RENTABLES

query = """
        SELECT ProductName, SUM(Price * Quantity) as Revenue
        FROM OrderDetails as od
        JOIN PRODUCTS as p ON p.ProductID = od.ProductID
        GROUP BY od.ProductID
        ORDER BY Revenue DESC
        LIMIT 10
            """

#Lee la consulta directa desde pandas, creando automaticamente cursor ... (consulta, conexion)
top_products = pd.read_sql_query(query, conn)

top_products.plot(x = "ProductName", y = "Revenue", kind = "bar", figsize= (10,5), legend = "False")
plt.title("10 productos mas rentables")
plt.xlabel("Productos")
plt.ylabel("Revenue")
plt.xticks(rotation=90)


#10 EMPLEADOS MAS EFECTIVOS

query2 = """
    SELECT CONCAT(FirstName," ",LastName) as Name, COUNT(*) as Total
    FROM orders as o
    JOIN employees as e
    ON o.EmployeeID = e.EmployeeID
    GROUP BY o.EmployeeID
    ORDER BY Total DESC
    LIMIT 10
"""

top_employees = pd.read_sql_query(query2, conn)
top_employees.plot(x="Name", y= "Total", kind="bar", figsize=(10,5), legend=False)

plt.title("TOP empleados")
plt.xlabel("Empleados")
plt.ylabel("Total")
plt.xticks(rotation=45)
plt.show()