/*
Copiar el archivo AdventureWorks2012_Data.mdf a la carpeta C:\Databases
Si el nombre no es ese, cambiarlo en la intrucción
*/

CREATE DATABASE AdventureWorks2012
ON (FILENAME = 'C:\Databases\AdventureWorks2012_Data.mdf')
FOR ATTACH_REBUILD_LOG ;