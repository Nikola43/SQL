--use Northwind

/* 1º Ejercicio
Deseamos incluir un producto en la tabla Products llamado "Cruzcampo botellín” pero no estamos 
seguros si se ha insertado o no.
El precio son 2,40, el proveedor es el 16, la categoría 1 y la cantidad por unidad son "Pack de seis botellines” 
El resto de columnas se dejarán a NULL.
Escribe un script que compruebe si existe un producto con ese nombre. En caso afirmativo, actualizará el precio
y en caso negativo insertarlo.
*/
if exists (select ProductName from Products where ProductName='Cruzcampo botellín')
begin--Inicio if
	Update Products							--Actualizamos si existe
		set UnitPrice =2.40 
end --fin if
else
 begin --Inicio else
	insert into Products
		(
		 ProductName,
		 SupplierID,					--Si no, lo insertamos
		 CategoryID,
		 QuantityPerUnit,
		 UnitPrice,
		 Discontinued
		 )
		 values
		 (
		  'Cruzcampo botellín',
		  16,
		  1,
		  'Pack seis botellines',
		  2.40,
		  0)end --fin else
		  
			
			

/*2ºEjercicio*/ 
/*Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID,
el Nombre, el Precio unitario, el número total de unidades vendidas y el total de dinero facturado con ese producto.*/

--Si la tabla esta creada solo pinta
if exists(select * from sysobjects where name='ProductSales')begin print('Ya esta creada') end
--Si no la creamos con las especificaciones
else begin 
			
			create table ProductSales (ID int not null Primary key,
									   UnitPrice int not null,
									   UnidadesVendidas int null default 0,
									   TotalFacturado int null default 0,
									   CONSTRAINT FK_PRODUCTID FOREIGN KEY(ID) REFERENCES Products (ProductID)
									   ON UPDATE CASCADE ON DELETE NO ACTION
									   )
	 end

	 insert into ProductSales(ID,UnitPrice,UnidadesVendidas,TotalFacturado)
		select  ProductID,UnitPrice,sum(Quantity) as UnidadesVendidas,sum(Quantity*UnitPrice) as TotalFacturado
		from [Order Details]




--PARA COMPROBAR SI EXISTE UNA TABLA

--if OBJECT_ID('ShipShip') = null
	

--or
--en master hay una lista sysobject en esta tabla esta la informacion de todas las bdd que tengamos en el swerver
--haciendo select * from sysobject where name='Shipship'

--si ese select existe devolvera una fila si no no, entonces haremos un exist.


/*3º Ejercicio
Comprueba si existe una tabla llamada ShipShip. 
Esta tabla ha de tener de cada Transportista el ID,
 el Nombre de la compañía, el número total de envíos que ha efectuado y 
 el número de países diferentes a los que ha llevado cosas. Si no existe, créala
*/

if exists ( select * from sysobjects where name='ShipShip' ) begin
	print('Ya esta creada')
end
else begin
	create table ShipShip 
		(ID int not null primary Key,			
		NombreCompañia varchar(50) not null,
		Num_Total_Envios int null default 0,
		Paises_Diferentes int null default 0,
		constraint fk_SHIP foreign key(ID) references shippers(ShipperId)
		 ON UPDATE CASCADE ON DELETE NO ACTION
		)

end --FIN ELSE

insert into ShipShip(ID,NombreCompañia,Num_Total_Envios,Paises_Diferentes)
	select s.ShipperID, CompanyName,count(*) as TotalEnvios, count (distinct o.ShipVia) as PaisesDiferentes
	from Shippers as s
	join Orders as o
	on o.ShipVia=s.ShipperID
		--ME FALTA PONER ESTO BIEN

/*4º Ejercicio*/
/*Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID,
 el Nombre completo, el número de ventas totales que ha realizado,
  el número de clientes diferentes a los que ha vendido y el total de dinero facturado. Si no existe, créala*/

  if exists (select * from sysobjects where name='EmployeeSales')begin
	print('Ya creada')											--if q no
	end


	else begin
		create table EmployeeSales (ID int not null foreign key references Employees(EmployeeID),
									nombre varchar(30) not null,
									apellido varchar(30) not null,	--CREAMOS LA TABLA
									numVentasTotal int not null,
									numClientesdiferentes int not null,
									totalDineroFacturado bigint not null )
	end
	
		insert into EmployeeSales(ID,nombre,apellido,numVentasTotal,numClientesdiferentes,totalDineroFacturado)
		select e.employeeID,firstName, lastName, count(*)as numVentasTotal,count(distinct CustomerID) as numClientesdiferentes
				,sum(quantity*UnitPrice)as totalDineroFacturado
			from dbo.Employees as e
				join dbo.orders as o
					on e.EmployeeID=o.EmployeeID
				join dbo.[Order Details] as od					--METEMOS DATOS
					on o.OrderID=od.OrderID
		
/*4º Ejercicio*/
/*Entre los años 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido.
 Queremos cambiar el precio unitario según la siguiente tabla*/
 

 go
 create view VentasEntre9697 as 
 select  od.ProductID, (sum(ventas97.CantidadVendida)-sum(ventas96.cantidadVendida)) as ventas9697, sum(ventas96.cantidadVendida) as Vendido96
	from [Order Details] as od
	join (select ProductId,(quantity) as cantidadVendida from Orders as o
							join [Order Details] as od
								on o.OrderID=od.OrderID
				where year(OrderDate)=1996
				--group by od.ProductID
			) as ventas96
			on ventas96.ProductID=od.ProductID
		join (
				select ProductId,(quantity) as CantidadVendida from Orders as o
							join [Order Details] as od
								on o.OrderID=od.OrderID
				where year(OrderDate)=1997
				--group by od.ProductID
				) as ventas97
		on	od.ProductID=ventas97.ProductID
		group by od.ProductID
		
		
		

go

 /*INCREMENTO DE VENTAS ---INCREMENTO DE PRECIO*/
 --  NEGATIVO			--- -10%
 --	 entre 0 y 10%		---	No varia
 --  entre 10% y 50%		---	+5%
 --	 Mayor del 50%		--- 10% co un un maximo de 2.25
 update Products
 set unitPrice = CASE 
					when  ventas9697 <0 then (UnitPrice-(UnitPrice*0.10)) 
					when ventas9697>=0 and ventas9697<(Vendido96*0.10) then UnitPrice																				
					when ventas9697>=(Vendido96*0.10) and ventas9697<(vendido96*0.50) then (UnitPrice*1.05)

					when ventas9697>=(Vendido96*0.50) then Case
																when (UnitPrice*0.10)<2.25 then
																(UnitPrice+ (UnitPrice*0.10))
																else 
																(UnitPrice+ 2.25)
																end
																
					end
	from ventasEntre9697
	where Products.ProductID=VentasEntre9697.ProductID		--FALTA PONER PARA LOS VALORES 