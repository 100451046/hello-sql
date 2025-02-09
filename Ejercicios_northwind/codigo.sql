-- 1.15
SELECT OrderID, ProductID, UnitPrice, Quantity, (Quantity * UnitPrice) as Total FROM order_details

--1.16
SELECT o.OrderID, OrderDate, ProductID, UnitPrice, o.EmployeeID, CONCAT(FirstName, " ", LastName) AS NombreCompleto FROM orders as o
JOIN order_details as od
ON o.OrderID = od.OrderID
JOIN employees as e
ON o.EmployeeID = e.EmployeeID

--2.5
SELECT o.OrderID, CompanyName, o.CustomerID, o.OrderDate, od.UnitPrice, p.ProductName FROM orders as o
JOIN customers as c
ON o.CustomerID = c.CustomerID
JOIN order_details as od
ON o.OrderID = od.OrderID
JOIN products as p
ON od.ProductID = p.ProductID

--2.6
SELECT CategoryName, COUNT(*) as TotalEachCategory FROM categories as c
JOIN products as p
ON p.CategoryID = c.CategoryID
GROUP BY CategoryName

--2.7
SELECT ProductName, SUM(od.Quantity) as Total_sold FROM products as p
JOIN order_details as od
ON od.ProductID = p.ProductID
GROUP BY ProductName
ORDER BY Total_sold DESC LIMIT 5

--2.8
SELECT CONCAT(e1.LastName," ",e1.FirstName) AS EMPLEADO ,e1.ReportsTo, 
CONCAT(e2.LastName," ",e2.FirstName) AS JEFE FROM Employees as e1
JOIN Employees as e2
ON e1.ReportsTo = e2.EmployeeID

--2.12
SELECT e.FirstName, e.LastName, OrderID FROM employees as e
JOIN orders as o
ON o.EmployeeID = e.EmployeeID
WHERE FirstName = "Robert" AND LastName = "King"

--2.13
SELECT OrderID, o.CustomerID, CompanyName FROM orders as o
JOIN customers as c
ON o.CustomerID = c.CustomerID
WHERE CompanyName = "Que delicia"

--2.15
SELECT orderID, od.ProductID, ProductName, od.UnitPrice, UnitsInStock FROM order_details as od
JOIN products as p
ON od.ProductID = p.ProductID
WHERE od.OrderID = "10257"

--2.16
SELECT o.OrderDate, od.ProductID, ProductName, od.UnitPrice, UnitsInStock FROM order_details as od
JOIN products as p
ON od.ProductID = p.ProductID
JOIN orders as o
ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) BETWEEN 1997 AND 2025

--2.19
SELECT CategoryName,ProductName,UnitPrice,UnitsInStock          
FROM Categories AS C             
INNER JOIN Products AS P      
ON C.CategoryID=P.CategoryID

-- Extra: Media del precio de los productos que pertenecen a cada categoría
-- Recuerda GROUP BY funciona cuando se usa una funcion SUM, AVG, etc y aquellos valores
-- que no tengan esas funciones en el SELECT, tienen que pertenecer al GROUP BY.
SELECT CategoryName,AVG(UnitPrice)          
FROM Categories AS C             
INNER JOIN Products AS P      
ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryName

-- 2.21 (mejor forma a mi parecer)
SELECT CategoryName, SUM(UnitsInStock)          
FROM Categories AS C             
INNER JOIN Products AS P      
ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryName

-- 2.22 (se puede cambiar c/s.ContactName por .CompanyName, depende de la interpretación
SELECT o.OrderID, c.ContactName as Client, s.ContactName as Proveed, e.FirstName as Employee, p.ProductName FROM orders as o
JOIN customers as c ON c.CustomerID = o.CustomerID
JOIN employees as e ON e.EmployeeID = o.EmployeeID
JOIN order_details as od ON od.OrderID = o.OrderID
JOIN products as p ON p.ProductID = od.ProductID
JOIN suppliers as s ON s.SupplierID = p.SupplierID
WHERE o.OrderID = "10794"

-- 2.23 (pero va mas alla, hace un JOIN para hacerlo con los nombres de los clientes, si fuera
-- solo con el CustomerID no haria falta el JOIN)
SELECT c.ContactName, YEAR(OrderDate), COUNT(*) as NumeroOrdenes FROM customers as c
JOIN orders as o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, YEAR(o.OrderDate)
ORDER BY c.ContactName, YEAR(o.OrderDate)

-- 2.24
SELECT YEAR(OrderDate), MONTH(OrderDate), COUNT(*) as Total_ordenes_por_año_y_mes    
FROM Orders         
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)

-- 2.25 (como tip, si alguna vez devuelve 0 rows, revisa que los "ON ... " coincidan los atributos en el =.
SELECT c.CompanyName, o.OrderID, o.OrderDate, p.ProductID, od.Quantity, 
p.ProductName, s.CompanyName, s.City FROM orders as o
JOIN order_details as od ON od.OrderID = o.OrderID
JOIN customers as c ON c.CustomerID = o.CustomerID
JOIN products as p ON p.ProductID = od.ProductID
JOIN suppliers as s ON s.SupplierID = p.SupplierID

-- 2.26 (Para expresiones regulares mas complejas, en MySQL usar REGEXP en vez de LIKE)
SELECT c.CompanyName, c.ContactName, o.OrderID, o.OrderDate, p.ProductID, od.Quantity, p.ProductName, s.CompanyName FROM orders as o
JOIN order_details as od ON od.OrderID = o.OrderID
JOIN customers as c ON c.CustomerID = o.CustomerID
JOIN products as p ON p.ProductID = od.ProductID
JOIN suppliers as s ON s.SupplierID = p.SupplierID
WHERE s.CompanyName REGEXP '^[A-G]' AND od.Quantity BETWEEN 27 AND 187