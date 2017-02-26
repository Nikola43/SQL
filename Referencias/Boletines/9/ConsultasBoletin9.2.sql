

--1. N�mero de clientes de cada pa�s.
SELECT Country, COUNT(CustomerID) AS NumberCustomers FROM Customers
	--WHERE
	GROUP BY Country
	--HAVING
	--ORDER BY

--2. N�mero de clientes diferentes que compran cada producto.
SELECT P.ProductID, P.ProductName, COUNT(distinct C.CustomerID) AS NumberCustomers FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID=OD.ProductID
JOIN Orders AS O
On O.OrderID=OD.OrderID
JOIN Customers AS C
ON O.CustomerID=C.CustomerID
	--WHERE
	GROUP BY P.ProductID, P.ProductName
	--HAVING
	--ORDER BY

--3. N�mero de pa�ses diferentes en los que se vende cada producto.
SELECT P.ProductID, P.ProductName, COUNT(Distinct C.Country) AS NumberCountrys FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID=OD.ProductID
JOIN Orders AS O
On O.OrderID=OD.OrderID
JOIN Customers AS C
ON O.CustomerID=C.CustomerID
	--WHERE
	GROUP BY P.ProductID, P.ProductName
	--HAVING
	--ORDER BY

--4. Empleados que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�, �Tourti�re� o �Boston Crab Meat�.
SELECT E.FirstName, E.LastName, P.ProductName FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID=OD.ProductID
JOIN Orders AS O
On O.OrderID=OD.OrderID
JOIN Employees AS E
ON O.EmployeeID=E.EmployeeID
	WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalik��ri', 'Tourti�re', 'Boston Crab Meat')
	GROUP BY P.ProductName, E.FirstName, E.LastName
	--HAVING
	--ORDER BY

--5. Empleados que no han vendido nunca �Chartreuse verte� ni �Ravioli Angelo�.
SELECT E.FirstName, E.LastName FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID=OD.ProductID
JOIN Orders AS O
On O.OrderID=OD.OrderID
JOIN Employees AS E
ON O.EmployeeID=E.EmployeeID
	WHERE P.ProductName NOT IN ('Chartreuse verte', 'Ravioli Angelo')
	GROUP BY E.FirstName, E.LastName


--6. N�mero de unidades de cada categor�a de producto que ha vendido cada empleado.
SELECT E.FirstName, E.LastName, P.CategoryID, COUNT(P.CategoryID) as Quantity
FROM Products AS P
JOIN [Order Details] AS OD
ON P.ProductID=OD.ProductID
JOIN Orders AS O
On O.OrderID=OD.OrderID
JOIN Employees AS E
ON O.EmployeeID=E.EmployeeID
	GROUP BY P.CategoryID, E.FirstName, E.LastName
	ORDER BY E.LastName, P.CategoryID

--7. Total de ventas (US$) de cada categor�a en el a�o 97.
SELECT P.CategoryID, SUM(o.Quantity*o.UnitPrice) as TotalySales FROM Products as p
JOIN [Order Details] as o
ON p.ProductID=o.ProductID
JOIN Orders as d
ON o.OrderID=d.OrderID
	WHERE YEAR(d.OrderDate)=1997
	GROUP BY p.CategoryID
	--HAVING
	ORDER BY p.CategoryID

--8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el nombre del producto, el pa�s y el n�mero de clientes distintos de ese pa�s que lo han comprado.
SELECT p.ProductName, c.Country, COUNT(c.CustomerID) as CustomerQty FROM Customers as c
JOIN Orders as o
ON c.CustomerID=o.CustomerID
JOIN [Order Details] as od
ON o.OrderID=od.OrderID
JOIN Products as p
ON od.ProductID=p.ProductID
	--WHERE CustomerQty>1
	GROUP BY p.ProductName, c.Country
	HAVING COUNT(c.CustomerID)>1
	--ORDER BY


--9. Total de ventas (US$) en cada pa�s cada a�o.
SELECT s.Country, YEAR(o.OrderDate) as Year, SUM(od.Quantity*od.UnitPrice) as Qty FROM Suppliers as s
JOIN Products as p
ON s.SupplierID=p.SupplierID
JOIN [Order Details] as od
ON p.ProductID=od.ProductID
JOIN Orders as o
ON od.OrderID=o.OrderID
	--WHERE
	GROUP BY s.Country, YEAR(o.OrderDate)
	--HAVING
	ORDER BY s.Country, YEAR(o.OrderDate)

--10. Producto superventas de cada a�o, indicando a�o, nombre del producto, categor�a y cifra total de ventas.
/*
SELECT YEAR(o.OrderDate) as Year, p.ProductName, p.CategoryID, SUM(od.Quantity) as TotalySales FROM Products as p
JOIN [Order Details] as od
ON p.ProductID=od.ProductID
JOIN Orders as o
ON od.OrderID=o.OrderID
	--WHERE
	GROUP BY YEAR(o.OrderDate), p.ProductName, p.CategoryID
	--HAVING
	ORDER BY YEAR(o.OrderDate), p.ProductName
*/

--11. Cifra de ventas de cada producto en el a�o 97 y su aumento o disminuci�n respecto al a�o anterior en US $ y en %.
SELECT p.ProductName, YEAR(o.OrderDate) as Year, SUM(od.Quantity) AS Qty FROM Products as p
JOIN [Order Details] as od
ON p.ProductID=od.ProductID
JOIN Orders as o
ON od.OrderID=o.OrderID
	WHERE YEAR(o.OrderDate)=1997
	GROUP BY p.ProductName, YEAR(o.OrderDate)
	--HAVING 
	--ORDER BY

--12. Mejor cliente (el que m�s nos compra) de cada pa�s.
SELECT c.CompanyName, c.Country, SUM(od.Quantity) FROM [Order Details] as od
	JOIN Orders as o
	ON od.OrderID=o.OrderID
	JOIN Customers as c
	ON o.CustomerID=c.CustomerID
	JOIN (SELECT ) AS 
	--WHERE
	--GROUP BY
	--HAVING
	--ORDER BY

--13. N�mero de productos diferentes que nos compra cada cliente.


--14. Clientes que nos compran m�s de cinco productos diferentes.


--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el a�o 97.


--16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos a�os consecutivos, indicando el a�o en que se produjo el aumento.