/*Boletin 12.1
Tabla para pruebas
USE Ejemplos
*/
GO

CREATE TABLE Palabrotas (
            ID SmallInt Not Null Identity Constraint PK_Palabrotas Primary Key
			,Palabra VarChar(30) Null

)

/*
Nota: No olvides probar cada trigger con diferentes valores.

Iniciación:
Sin usar datos modificados
1.- Queremos que cada vez que se actualice la tabla Palabras aparezca un mensaje diciendo si se han añadido, borrado o actualizado filas.
Pista: Crea tres triggers diferentes
*/
--trigger que se ejecutara despues de insertar

go
create trigger DespuesDeInsertar on Palabrotas
	after Insert 
		as print'Se han insertado datos en la tabla palabrota'


--trigger que se ejecutara despues de actualizar

go
create trigger DespuesDeActualizar on Palabrotas
	after Update 
		as print'Se ha actualizado la tabla palabrota'

--trigger que se ejecutara despues de borrar

go
create trigger DespuesDeBorrar on Palabrotas
	after Delete 
		as print'Se han eliminado  datos en la tabla palabrota'


begin transaction
go
insert into Palabrotas(Palabra)
				values('Electroencefalografista')
					,('Esternocleidomastoideo')
					,('Electroencefalografía')
					,('Electroencefalogramas')
					,('Otorrinolaringólogo')
					,('Electrocardiograma')
					,('Electrodoméstico')
					,('Arteriosclerosis')

--rollback
commit transaction


begin transaction
go
update Palabrotas
	set Palabra=Palabra + 'dls Pirineos'
	where Palabra='Electrocardiograma'

--rollback
commit transaction



begin transaction
go
delete from Palabrotas where Palabra='Arteriosclerosis'

--rollback
commit transaction

select * from Palabrotas



/*
2.- Haz un trigger que cada vez que se aumente o disminuya el número de filas de la tabla Palabras nos diga cuántas filas hay.
*/

go  ---filas de la tabla after insert 
create trigger AumentoFilas on Palabrotas
 after Insert as 
	declare  @filasTabla  int 
	    set  @filasTabla=(select count(ID) from Palabrotas)
	print 'La tabla tiene ' +cast(@filasTabla  as varchar)

begin transaction 
go
	insert into Palabrotas(Palabra)
				values('Electroencefalogramador')

--rollback
commit transaction
	

---filas de la tabla after deleteç
go
create trigger DisminuyenFilas on Palabrotas
 after delete as 
	declare  @filasTabla  int 
	    set  @filasTabla=(select count(ID) from Palabrotas)
	print 'La tabla tiene ' +cast(@filasTabla  as varchar)


begin transaction
go

  delete from Palabrotas where Palabra='Electrodoméstico'

--rollback
commit transaction

/*
Medio:
Se usan inserted y deleted. Si es complicado procesar varias filas, supón
que se modifica sólo una.
3.- Cada vez que se inserte una fila queremos que se muestre un mensaje indicando
“Insertada la palabra ________”
*/
select Palabra from Palabras2

go
alter trigger PalabraInsertada on Palabras2
	after insert as 
		declare @palabraInsertada  varchar(30)
		select @palabraInsertada=Palabra from inserted
		begin
		 print 'Insertada la palabra *U* ' +@palabraInsertada
		end
GO
insert into Palabras2(Palabra)
				values('Electron')


go
create trigger PalabrasInsertadas on Palabras2
	after insert as 
			declare @palabraFilas varchar(30) --variable donde almacenamos las palabras de inserted
			declare palabrasInsertadas cursor for select Palabra from inserted   -- declaramos el cursor
			open palabrasInsertadas  
			--lectura anticipada
			fetch next from palabrasInsertadas into @palabraFilas  --posiciona el cursor en la primera fila , la primera vez   
			while @@FETCH_STATUS=0  -- mientras queden filas , va a ser 0 mientras hayan filas ;)
				begin
					print 'Insertada la palabra :) ' +@palabraFilas
					--lectura final
					fetch next from palabrasInsertadas into @palabraFilas  -- se pone el la fila siguiente
				end
			close palabrasInsertadas  
			dealLocate palabrasInsertadas  --deja de existir el cursor



begin transaction
go
insert into Palabras2(Palabra)
				values('cleidomastoideo')
					 ,('cefalografía')
go

--rollback
commit transaction 



/*
4.- Cada vez que se inserten filas que nos diga “XX filas insertadas”
*/



/*
5.- que no permita introducir palabras repetidas (sin usar UNIQUE).
Sobre LeoMetro
*/


/*
6.- Comprueba que un pasajero no pueda entrar o salir por la misma estación más de tres
veces el mismo día
7.- Haz un trigger que al insertar un viaje compruebe que no hay otro viaje simultáneo
Avanzado:
Se incluye la posibilidad de que se modifiquen varias filas y de que haya
que consultar otras tablas.
8.- Queremos evitar que se introduzcan palabras que terminen en “azo”
Sobre LeoFest
9.- Cuando se inserte una nueva actuación de una banda hemos de comprobar que la banda
no se ha disuelto en esa fecha.
10 .- Comprueba mediante un trigger que en una edición no actúan más de tres bandas de la
misma categoría. 