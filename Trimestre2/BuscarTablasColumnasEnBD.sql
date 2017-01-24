USE AdventureWorks2012

-- Buscar tabla en bd
DECLARE @Tabla varchar(50) = '%state%';

SELECT      c.name  AS 'ColumnName' ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables t ON c.object_id = t.object_id
WHERE       c.name LIKE @Tabla
ORDER BY    TableName, ColumnName;

-- Buscar columna en bd
DECLARE @Columna varchar(30) = '%state%'
select * from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like @Columna
order by TABLE_NAME