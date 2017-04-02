Go
USe AirLeo
Go

--Bolet�n 11.2
--Sobre la base de datos AirLeo.

/* Ejercicio 1
Escribe un procedimiento que cancele un pasaje y las tarjetas de embarque asociadas. Recibir� como par�metros el ID del pasaje.*/

Begin Transaction

Go
--Create Procedure cancelarPasajesTarjetas @IDPasaje int
Alter Procedure cancelarPasajesTarjetas @IDPasaje int
As
	Begin
		Delete AL_Tarjetas Where Numero_Pasaje = @IDPasaje --De esta forma gasta menos recursos
		Delete AL_Vuelos_Pasajes Where Numero_Pasaje = @IDPasaje --Va en medio por las foreign keys
		Delete AL_Pasajes Where Numero = @IDPasaje
	End
Go

Rollback
Commit Transaction

Begin Transaction

Go
Execute cancelarPasajesTarjetas 40
Go

Rollback
Commit Transaction

--Lo comprobamos
Select tar.Codigo_Vuelo, tar.Fila_Asiento, tar.Letra_Asiento, tar.Numero_Pasaje, tar.Peso_Equipaje From AL_Tarjetas As tar
		Inner Join AL_Pasajes As pas On tar.Numero_Pasaje = pas.Numero
		Order By tar.Numero_Pasaje

/* Ejercicio 2
Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y devuelva en un par�metro de salida el n�mero de 
vuelos diferentes que ha tomado ese pasajero.*/

Begin Transaction

Go
Alter Procedure devolverVuelosPasajero 
	@IDPasajero char (9) , --Entrada
	@numeroVuelos int Output --Salida
As
	Begin
		Set @numeroVuelos = --Modificamos el valor de @numeroVuelos
		(
			Select Count (vp.Codigo_Vuelo) As vuelos 
			From AL_Pasajes As pas
			Inner Join AL_Vuelos_Pasajes AS vp On pas.Numero = vp.Numero_Pasaje
			Where @IDPasajero = pas.ID_Pasajero
			Group By pas.ID_Pasajero
		)
	End
Go

Rollback
Commit Transaction

Begin Transaction

Go
Declare @numVuelos int --Declarar esa variable
Execute devolverVuelosPasajero 'A003', @numVuelos Output
Print 'El pasajero ha volado '+Cast (@numVuelos As varchar (10))+' veces.'
Go

Rollback
Commit Transaction

/* Ejercicio 3
Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y dos fechas y nos devuelva en otro par�metro 
(de salida) el n�mero de horas que ese pasajero ha volado durante ese intervalo de fechas.*/

Begin Transaction

Go
Alter Procedure horasVuelo 
	@IDPasajero char (9) , --Entrada
	@fechaInicio date, --Entrada
	@fechaFin date, --Entrada
	@horasTotales int Output --Salida
As
	Begin
		Set @horasTotales =
		(
			Select SUM (Datediff (Minute, vuel.Salida, vuel.Llegada)/60.0) As Horas --Devuelve la diferencia en horas 
			From AL_Pasajeros As pasa
			Inner Join AL_Pasajes As pas On pasa.ID = pas.ID_Pasajero
			Inner Join AL_Vuelos_Pasajes As vp On pas.Numero = vp.Numero_Pasaje
			Inner Join AL_Vuelos As vuel On vp.Codigo_Vuelo = vuel.Codigo
			Where vuel.Salida >= @fechaInicio And vuel.Llegada <= @fechaFin And pasa.ID = @IDPasajero
			Group By pasa.ID
		)
	End
Go

Rollback
Commit Transaction

Begin Transaction

Go
Declare @fechaInicio Date = Datefromparts (2012, 1, 14)
Declare @fechaLlegada Date = Datefromparts (2016, 1, 23)
Declare @horasTotales int
Execute horasVuelo 'A008', @fechaInicio, @fechaLlegada, @horasTotales Output
Print 'Ese pasajero ha volado '+Cast (@horasTotales As Varchar (30))+' horas entre las fechas '+Cast (@fechaInicio As Varchar (30))+' y '+Cast (@fechaLlegada As Varchar (30))
Go

Rollback
Commit Transaction

/* Ejercicio 4
Escribe un procedimiento que reciba como par�metro todos los datos de un pasajero y un n�mero de vuelo y realice el siguiente proceso:
-En primer lugar, comprobar� si existe el pasajero. Si no es as�, lo dar� de alta.
-A continuaci�n comprobar� si el vuelo tiene plazas disponibles (hay que consultar la capacidad del avi�n) y en caso afirmativo crear� 
un nuevo pasaje para ese vutraicionelo.*/

/* Ejercicio 5
Escribe un procedimiento almacenado que cancele un vuelo y reubique a sus pasajeros en otro. 
Se ocupar�n los asientos libres en el vuelo sustituto. Se comprobar� que ambos vuelos realicen el mismo recorrido. 
Se borrar�n todos los pasajes y las tarjetas de embarque y se generar�n nuevos pasajes. 
No se generar�n nuevastraicion tarjetas de embarque. El vuelo a cancelar y el sustituto se pasar�n como par�metros. 
Si no se pasa el vuelo sustituto, se buscar� el primer vuelo inmediatamente posterior al cancelado que realice el mismo recorrido.*/

/* Ejercicio 6
Escribe un procedimiento al que se pase como par�metros un c�digo de un avi�n y un momento (dato fecha-hora) y nos escriba un mensaje 
que indique d�nde se encontraba ese avi�n en ese momento. El mensaje puede ser "En vuelo entre los aeropuertos de NombreAeropuertoSalida 
y NombreaeropuertoLlegada� si el avi�n estaba volando en ese momento, o "En tierra en el aeropuerto NombreAeropuerto� si no est� volando. 
Para saber en qu� aeropuerto se encuentra el avitraici�n debemos consultar el �ltimo vuelo que realiz� antes del momento indicado.
Si se omite el segundo par�metro, se tomar� el momento actual.*/