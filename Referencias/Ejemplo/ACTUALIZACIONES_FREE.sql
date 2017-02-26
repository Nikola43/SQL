use Northwind
/*Inserta un nuevo cliente.*/
go

insert into Customers(CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax)
values('OLALA','LAVIDAEDURA','Dani',NULL,'Alicante.8','Berlin', NULL,12209,'Germany',65559888,NULL)
go
/*Véndele (hoy) tres unidades de "Pavlova”, diez
 de "Inlagd Sill” y 25 de "Filo Mix”. El distribuidor será Speedy Express y el vendedor Laura Callahan.
*/
select * from Employees as c  where c.FirstName='Laura'

select * from Orders where CustomerID='OLALA'
--INSERTAMOS LA COMPRA DE Dani A LAURA CALLAHAN 
Insert into Orders(CustomerID, EmployeeID, OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
		select TOP 1 c.CustomerID,
				8,
				GETDATE(),
				NULL,
				NULL,
				s.ShipperID,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
				from Shippers as s, Customers as c where c.ContactName='Dani' AND s.CompanyName='Speedy Express'
			go

			select * from [Order Details] where ProductID=16 and Quantity='3' and OrderID=11078
			select * from Products where ProductName='Pavlova'
			begin transaction
		
		--INSERTAMOS LA VENTA DE 3 PRODUCTOS PAVLOVA
		Insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
		select o.OrderID,
			   p.ProductID,
			   p.UnitPrice,
			   3,
			   0.0
		from Orders as o, Products as p where CustomerID='OLALA' and P.ProductName='Pavlova'
		--INSERTAMOS LA VENTA DE 10 PRODUCTOS "Inlagd Sill”
				Insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
		select o.OrderID,
			   p.ProductID,
			   p.UnitPrice,
			   10,
			   0.0
		from Orders as o, Products as p where CustomerID='OLALA' and P.ProductName='Inlagd Sill'

		--INSERTAMOS LA VENTA DE 25 PRODUCTOS "Filo Mix”
				Insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
		select o.OrderID,
			   p.ProductID,
			   p.UnitPrice,
			   25,
			   0.0
		from Orders as o, Products as p where CustomerID='OLALA' and P.ProductName='Filo Mix'


		commit transaction 

 /*
Ante la bajada de ventas producida por la crisis, hemos de adaptar nuestros precios según las siguientes reglas:
Los productos de la categoría de bebidas (Beverages) que cuesten más de $10 reducen su precio en un dólar.
Los productos de la categoría Lácteos que cuesten más de $5 reducen su precio en un 10%.
Los productos de los que se hayan vendido menos de 200 unidades en el último año, reducen su precio en un 5%
*/

go
--ACTUALIZAMOS LOS PRODUCTOS DE LA CATEGORIA BEBIDA
UPDATE [dbo].[Products]
   SET UnitPrice = (UnitPrice-1)
 WHERE CategoryID in( select c.CategoryID
						from Categories as c
						where c.CategoryName='Beverages'
					)
GO 
--ACTUALIZAMOS LOS PRODUCTOS QUE CUESTAN MAS QUE 5 DOLARES DE LA CATEGORIA DE LOS LACTEOS (CHEESES)
UPDATE [dbo].[Products]
   SET UnitPrice = UnitPrice-(UnitPrice*20/100)
 WHERE CategoryID in( select c.CategoryID
						from Categories as c
							join Products as p
								on c.CategoryID=p.CategoryID
						where c.CategoryName='Cheeses' and p.UnitPrice>5
					)
--ACTUALIZAMOS 
UPDATE Products
	set UnitPrice= UnitPrice-(UnitPrice*5/100)
	where ProductId in (select p.ProductID 
							from Products as p
								join [Order Details] as od
									on p.ProductID=od.ProductID
								join Orders as o
									on od.OrderID=o.OrderID

								--where YEAR(o.OrderDate)=DATEPART(YEAR,GETDATE())-1		//NO HAY NINGUN ORDER EN ESTE AÑO LLEGA AL 98 
							where YEAR(o.OrderDate)=1997
							group by p.ProductID
							having sum(od.Quantity)<200
	
						)
/*
Inserta un nuevo vendedor llamado Michael Trump. Asígnale los territorios de Louisville, Phoenix, Santa Cruz y Atlanta.
Haz que las ventas del año 97 de Robert King que haya hecho a clientes de los estados de California
y Texas se le asignen al nuevo empleado.
*/
select * from Employees

Insert into Employees(LastName,FirstName,Title,TitleOfCourtesy,BirthDate)
	Values ('Trump','Michael','PRESIDENT','Dr.',YEAR(GETDATE()-50))

/*
Inserta un nuevo producto con los siguientes datos:
ProductID: 90
ProductName: Miel El Zangano Zumbón
SupplierID: 12
CategoryID: 3
QuantityPerUnit: 10 x 300g
UnitPrice: 2,40
UnitsInStock: 38
UnitsOnOrder: 0
ReorderLevel: 0
Discontinued: 0
*/

select * from Products
SET identity_Insert Products on
SET identity_Insert Products off
Insert into Products
(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
values(90,'Miel El Zangano Zumbón',12,3,'10 x 300g',2.40,38,0,0,0)


rollback
commit transaction
/*
Inserta un nuevo producto con los siguientes datos:
ProductID: 91
ProductName: Licor de bellotas
SupplierID: 1
CategoryID: 1
QuantityPerUnit: 6 x 75 cl
UnitPrice: 7,35
UnitsInStock: 14
UnitsOnOrder: 0
ReorderLevel: 0
Discontinued: 0
*/
select * from Products
Insert into Products
(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
values('Licor de bellotas',1,1,'6 x 75 cl',7.35,14,0,0,0)


/*Todos los que han comprado "Outback Lager" han comprado cinco años después la misma cantidad de Licor de 
Bellota al mismo vendedor*/
select * from [Order Details]

begin transaction 


--PRIMERO INSERTAMOS LAS COMPRA CON LA FECHA CAMBIADA Y CON LAS NUEVAS ORDER ID
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
select o.[CustomerID]
           ,[EmployeeID]
           ,DATEADD(year,5,[OrderDate]) as [OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry]
		   from Orders as o
			join [Order Details] as od  --HAGO UN JOIN CON OD PORQUE EN ESA TABLA ESTA LA ID DEL PRODUCTO
				on o.OrderID=od.OrderID
			join Products as p
				on od.ProductID=p.ProductID  --Y AHORA CON PRODUCTO PARA PODER LUEGO HACER EL WHERE CON EL NOMBRE DEL PRODUCTO
		   where p.ProductName='Outback Lager'


		--insertamos ahora los DETALLES DE LAS COMPRAS QUE HEMOS INSERTADO EN Orders
		begin transaction


	INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
	select 
			ultimosañadidos.[OrderID]
           ,nuevoProducto.[ProductID]
           ,nuevoProducto.[UnitPrice]
           ,cantidad.Quantity
           ,0
		   from [Order Details] as od
	
			join (select ProductID, UnitPrice
					from Products
					where ProductName='Licor de bellotas'		--DE esta subconsulta recogemos la id del producto Licor de bellotas y su precio
					)as nuevoProducto
				on od.ProductID=nuevoProducto.ProductID
			join(
				select o.OrderID,o.OrderDate
				from Orders as o		--Aqui unicamente tenemos que coger el Order id,    
					join
					(select DATEADD(YEAR,5,o.OrderDate) as Año		--PRIMERO LEER ESTO, para entenderlo
						from Orders as o						--Con esta subconsulta recojo la fecha de los que vendieron Outback Lager
							join [Order Details] as od				-- y le añado 5 años para poder coger la fecha de los nuevos que insertamos anteriormente
								on o.OrderID=od.OrderID
							join Products as p
								on od.ProductID=p.ProductID
						where p.ProductName='Outback Lager') as NuevoAño
						on o.OrderDate=NuevoAño.Año						--Este on nos iguala la fecha que hemos conseguido arriba con las fechas hay en orders
						)as ultimosañadidos
					on od.OrderID=ultimosañadidos.OrderID
				
				join(
					select Quantity
						from [Order Details] as od
							join Products as p
								on od.ProductID=p.ProductID			--DE ESTE JOIN COJO LA CANTIDAD QUE SE VENDIERON
							where p.ProductName='Outback Lager')	--CON EL PRODUCTO 'Outback Lager'
							as cantidad
				on od.Quantity=cantidad.Quantity
	
			
	rollback

/*
El pasado 20 de enero, Margaret Peacock consiguió vender una caja de Miel El Zangano Zumbón a 
todos los clientes que le habían comprado algo anteriormente.
Los datos de envío (dirección, transportista, etc) son los mismos de alguna de sus ventas anteriores a ese cliente).*/


select * from Orders

			select o.OrderID,o.OrderDate
				from Orders as o

					join(select o.OrderID,DATEADD(YEAR,5,o.OrderDate) as Año
						from Orders as o						--Con esta subconsulta recojo las id que vendieron Outback Lager
							join [Order Details] as od
								on o.OrderID=od.OrderID
							join Products as p
								on od.ProductID=p.ProductID
						where p.ProductName='Outback Lager'
						)as distintafecha
					 