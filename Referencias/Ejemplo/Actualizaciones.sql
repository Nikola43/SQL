--Usa la base de datos NorthWind



--1.Inserta un nuevo cliente.
select * from Customers

begin transaction
INSERT INTO Customers(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country, Phone )
VALUES('AAAAA','Multinacional Mercedes', 'Mercedes Requena', 'Reina de España', 'Bami 88','Sevilla', '0156 N','Galia','967568524')
--rollback transaction
commit transaction

--- me han subido de puesto de responsabilidad---
UPDATE Customers
SET ContactTitle='Emperatriz del Universo'
WHERE CustomerID='AAAAA'

--2.Véndele (hoy) tres unidades de "Pavlova”, diez de "Inlagd Sill” y 25 de "Filo Mix”. El distribuidor será Speedy Express y el vendedor Laura Callahan.
select * from Orders
select * from [Order Details]
select * from Products Order by ProductName
select * from Employees
select * from Shippers

set dateformat YMD

-----------hay 2 errores, no he puesto Speedy, ni a Laura
begin transaction
INSERT INTO Orders(CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipPostalCode, ShipCountry)
VALUES('AAAAA', 5 , CURRENT_TIMESTAMP, '2016-03-17 ', '2016-03-16 ', 3, 0, 'Mercedes Requena', 'Bami 88', 'Sevilla', '0156 N','Galia')
--rollback transaction
commit transaction
---correcion: laura es el 8-----
UPDATE Orders
SET EmployeeID = 8, ShipVia = 1
WHERE CustomerID='AAAAA'

------------------Pavlova-----------------------
begin transaction
INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES(11082, 16 , 17.45 , 3, 0 )
--rollback transaction
commit transaction
----------------------Inlagd Sill------------------
begin transaction
INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES(11082, 36 , 19.00 , 10, 0 )
rollback transaction
commit transaction
-----------------------Filo Mix--------------------

begin transaction
INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES(11082, 52 , 7.0 , 25, 0 )
rollback transaction
commit transaction

-- se pueden poner values() values()... seguidos!!!

--3.Ante la bajada de ventas producida por la crisis, hemos de adaptar nuestros precios según las siguientes reglas:
--		Los productos de la categoría de bebidas (Beverages) que cuesten más de $10 reducen su precio en un dólar.
--		Los productos de la categoría Lácteos que cuesten más de $5 reducen su precio en un 10%.
--		Los productos de los que se hayan vendido menos de 200 unidades en el último año, reducen su precio en un 5%
select * from Products order by ProductID
select * from Categories
			--bebidas
UPDATE Products
SET UnitPrice = UnitPrice-1
WHERE Products.CategoryID = 1 AND UnitPrice>10
			-- lacteos
begin transaction
UPDATE Products
SET UnitPrice = UnitPrice*0.9
WHERE Products.CategoryID = 4 AND UnitPrice>5
commit transaction
			--vendidos<200 unidades en el ultimo año
begin transaction
UPDATE Products
SET UnitPrice=UnitPrice*0.95
WHERE Products.ProductID IN(
							select
							P.ProductID
							from Products as P
							inner join [Order Details] as OD on OD.ProductID = P.ProductID
						--	inner join Orders as O on O.OrderID = OD.OrderID 
						--	where year(O.OrderDate)= 1997
							group by P.ProductID 
							having sum(OD.Quantity)<200		
							)		--si añado lo verde me dan 20 filas, si no 5 ¿?
commit transaction



								--error de categoria!! ya corregido
					--UPDATE Products
					--SET UnitPrice = UnitPrice*0.9
					--WHERE Products.CategoryID = 5 AND UnitPrice>5

					--UPDATE Products
					--set UnitPrice = UnitPrice+(UnitPrice*0.1)
					--WHERE Products.CategoryID = 5 AND UnitPrice>5

--4.Inserta un nuevo vendedor llamado Michael Trump. Asígnale los territorios de Louisville, Phoenix, Santa Cruz y Atlanta.
SELECT * FROM Employees

begin transaction
INSERT INTO Employees(LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath)
VALUES('Trump', 'Michael', 'Hermano del Presidente', 'Mr.', '1950-07-06', CURRENT_TIMESTAMP, 'Palace Street', 'Potala','0894 T','Tibet', '(123) 123-123', '5555', null, 'Simpatico', 2, null )
--rollback transaction
commit transaction

select * from Territories order by TerritoryDescription
select * from EmployeeTerritories

begin transaction
INSERT INTO EmployeeTerritories (EmployeeID, TerritoryID)
VALUES (11,40222)--Louisville					¿¿SE PUEDE METER EL CODIGO DE LOUISVILLE CON UN SELECT??
 ,(11,85014)--Phoenix
 ,(11,95060)--Santa Cruz
 ,(11,30346)--Atlanta
 commit transaction


--5.Haz que las ventas del año 97 de Robert King que haya hecho a clientes de los estados de California y Texas se le asignen al nuevo empleado.
select ShipRegion from Orders where ShipRegion in ('CA','TX') -- != 'NULL'
select * from Customers
select * from Orders
-- ventas (orders??) de Robert King en el 97, a clientes de CA y TX
SELECT * 
FROM Orders as O
inner join Employees as E on E.EmployeeID = O.EmployeeID 
WHERE E.FirstName = 'Robert' and E.LastName='King' and O.ShipRegion in ('CA','TX') and year(O.OrderDate)=1997

begin transaction
update Orders		--cambiar el employee de Robert, x el de Michael Trump en dichas Orders
set EmployeeID = (select EmployeeID from Employees where FirstName='Michael' and LastName='Trump')
where OrderID in (
					SELECT O.OrderID 
					FROM Orders as O
					inner join Employees as E on E.EmployeeID = O.EmployeeID 
					WHERE E.FirstName = 'Robert' and E.LastName='King' 
							and O.ShipRegion in ('CA','TX') 
							and year(O.OrderDate)=1997
					)
--rollback transaction
commit transaction


--6.Inserta un nuevo producto con los siguientes datos:
--		ProductID: 90
--		ProductName: Miel El Zangano Zumbón
--		SupplierID: 12
--		CategoryID: 3
--		QuantityPerUnit: 10 x 300g
--		UnitPrice: 2,40
--		UnitsInStock: 38
--		UnitsOnOrder: 0
--		ReorderLevel: 0
--		Discontinued: 0

begin transaction
--set identity_insert Products on

INSERT INTO [dbo].[Products]
           ([ProductID]
		   ,[ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
     VALUES
           (90
		   ,'Miel El Zangano Zumbón'
           ,12
           ,3
           ,'10 x 300g'
           ,2.40
           ,38
           ,0
           ,0
           ,0)
rollback transaction
commit transaction

set identity_insert Products off


--7.Inserta un nuevo producto con los siguientes datos:
--		ProductID: 91
--		ProductName: Licor de bellotas
--		SupplierID: 1
--		CategoryID: 1
--		QuantityPerUnit: 6 x 75 cl
--		UnitPrice: 7,35
--		UnitsInStock: 14
--		UnitsOnOrder: 0
--		ReorderLevel: 0
--		Discontinued: 0

begin transaction
--en este momento set identity_insert Products off , por lo que automaticamente se insertara en el 91 
	-- (90 fue el ultimo que yo inserte manualmente)
INSERT INTO [dbo].[Products]
           ([ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
     VALUES
           ('Licor de bellotas'
           ,1
           ,1
           ,'6 x 75 cl'
           ,7.35
           ,14
           ,0
           ,0
           ,0)
rollback transaction
commit transaction


select * from Products


--8.Todos los que han comprado "Outback Lager" han comprado cinco años después la misma cantidad de Licor de Bellota al mismo vendedor
select * from Customers
					-- TABLA TEMPORAL!! hay que crearla cada vez que la quiera usar (ocupa espacio, la vista no)
--begin transaction
select C.CustomerID,O.OrderID, O.EmployeeID, O.OrderDate, OD.Quantity into #CompradoresOutbackLager	
from Customers as C	
inner join Orders as O on O.CustomerID = C.CustomerID
inner join [Order Details] as OD on OD.OrderID = O.OrderID
inner join Products as P on P.ProductID = OD.ProductID
where P.ProductName = 'Outback Lager'
--commit transaction


--
begin transaction
INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
select
			Col.CustomerID
			,Col.EmployeeID
			,dateadd(year,5,Col.OrderDate)	--añadir tiempo 5 años
			,dateadd(day,365*5+2,Col.OrderDate)
			,dateadd(day,365*5+3,Col.OrderDate)
			,O.ShipVia
			,O.Freight
			,O.ShipName
			,O.ShipAddress
			,O.ShipCity
			,O.ShipRegion
			,O.ShipPostalCode
			,O.ShipCountry
from #CompradoresOutbackLager as COL
inner join Orders as O on O.OrderID = col.OrderID		-- mal O.CustomerID=COL.CustomerID afecta a 590 filas aprox!!


-- rollback transaction
commit transaction

select * from Orders

begin transaction

INSERT INTO [dbo].[Order Details]([OrderID]	,[ProductID] ,[UnitPrice] ,[Quantity] ,[Discount])
select O.OrderID, P.ProductID, P.UnitPrice,	col.Quantity, 0
from  #CompradoresOutbackLager	as COL 
inner join Orders as O on  O.OrderDate = dateadd(year,5,Col.OrderDate)  --O.CustomerID=col.CustomerID and
inner join Products as P on P.ProductID = (select ProductID from Products where ProductName='Licor de Bellotas') -- si añado esto no es necesario que ponga los select de arriba en verde
where O.OrderID = ANY (select 
						OrderID 
						from Orders 
						where OrderDate =ANY ( select 
												dateadd(year,5,Col.OrderDate) 
												from #CompradoresOutbackLager as COL 
												inner join Orders as O on O.OrderID = col.OrderID ))
		
	


-- MAL!!! asi me da 57 filas!! arriba me da 39 (lo correcto)
--select
--	O.OrderID,
--	(select ProductID from Products where ProductName='Licor de Bellotas'),
--	(select UnitPrice from Products where ProductName='Licor de Bellotas'),
--	col.Quantity,
--	0
--from  #CompradoresOutbackLager	as COL 
--inner join Orders as O on O.CustomerID=col.CustomerID
--where O.OrderID = ANY (select OrderID from Orders where OrderDate =ANY ( select dateadd(year,5,Col.OrderDate) from #CompradoresOutbackLager as COL inner join Orders as O on O.OrderID = col.OrderID ))
	




-- rollback transaction
commit transaction

select OrderDate from Orders
--     VALUES
--           ((select OrderID from Orders where OrderDate in( select dateadd(year,5,Col.OrderDate) from #CompradoresOutbackLager as COL inner join Orders as O on O.OrderID = col.OrderID ))
--           ,(select ProductID from Products where ProductName='Licor de Bellotas')
--           ,(select UnitPrice from Products where ProductName='Licor de Bellotas')
--           ,(select Quantity from [Order Details] as OD inner join Orders as O on O.OrderID= OD.OrderID where ProductID = (select ProductID from Products where ProductName='Outback Lager'))
--           ,0)




--9.El pasado 20 de enero, Margaret Peacock consiguió vender una caja de Miel El Zangano Zumbón a todos los clientes 
--que le habían comprado algo anteriormente. Los datos de envío (dirección, transportista, etc) son los mismos de alguna 
--de sus ventas anteriores a ese cliente)




--primero creamos los nuevos pedidos en Orders

begin transaction

INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
		   ,[ShipVia]
		   ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry] )
    select
		C.CustomerID,
		E.EmployeeID,
		'2016-01-20',
		'2016-01-21',
		'2016-01-22',
		O.ShipVia,
		O.Freight,
        O.ShipName
           ,O.ShipAddress
           ,O.ShipCity
           ,O.ShipRegion
           ,O.ShipPostalCode
           ,O.ShipCountry
	from Customers as C
	inner join Orders as O on O.CustomerID = C.CustomerID
	inner join Employees as E on E.EmployeeID = O.EmployeeID
	where E.FirstName = 'Margaret' and E.LastName = 'Peacock'

-- rollback transaction
-- commit transaction




-- Creamos las filas en Order Details
select * from Orders
select * from [Order Details]


begin transaction

INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity])
     select OrderID,
			(select ProductID from Products where ProductName = 'Miel El Zangano Zumbón'),
			(select UnitPrice from Products where ProductName = 'Miel El Zangano Zumbón'),
			1
		
          from Orders
		  where OrderDate = '2016-01-20'
-- rollback transaction
-- commit transaction