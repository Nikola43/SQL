USE Northwind
GO
-- Vins et alcools 
where ShipName like 'vins%'


-- insert 
INSERT INTO Orders (ShipName)
VALUES ('fg')


-- delete
DELETE FROM Orders 
where ShipName like 'fg'

SELECT * FROM Customers, ContactName
 CompanyName, Address, City, Country 