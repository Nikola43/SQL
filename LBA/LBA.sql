/*

2. Crea una restricción en la tabla LBA_Jugadores para asegurarte que el dorsal está
comprendido entre 0 y 99 y otra para asegurarte que el valor de la posición es válido. Los
valores válidos son B, A, P, E y L.
3. La fecha de fundación del equipo ha de ser anterior a la actual.
4. Crea una restricción en la tabla LBA_Juega para asegurar que el número de minutos, si
no es nulo, es positivo y menor que 40
5. Crea una restricción en la tabla LBA_Juega para asegurar que el número de tiros de un
jugador es menor o igual que los aciertos que les corresponden. Recuerda que las
columnas Puntos1, 2 y 3 contiene el número de puntos, y para hallar los aciertos hay que
dividir por su valor.
6. Las columnas Puntos_Local y Puntos_Visitante de la tabla LBA_Partidos deben estar a
NULL hasta que se celebre el partido.
*/


--USE master; DROP DATABASE LeoBasketAssociation
CREATE DATABASE LeoBasketAssociation
GO
USE LeoBasketAssociation
GO

-------------- PAISES ----------------
CREATE TABLE LBA_Paises
(
	-- Creacion de columnas
	ID Char(3) NOT NULL,
	Denominacion Varchar(25) NOT NULL,
	UE Bit NOT NULL,

	-- Creacion de claves PK y FK
	Constraint PK_LBA_Paises Primary Key (ID),
)


-------------- JUGADORES ----------------
-- RESTRICCIONES: 
	-- La edad de un jugador no puede ser inferior a quince años ni superior a cincuenta
	-- El dorsal está comprendido entre 0 y 99
	-- Posicion solo podria ser:  B, A, P, E y L.
CREATE TABLE LBA_Jugadores
(
	-- Creacion columnas
	Licencia     Char(10)    NOT NULL,
	Nombre       VarChar(20) NOT NULL,
	Apellidos    VarChar(30) NOT NULL,
	FechaNac     DATE        NULL,
	Dorsal       TinyInt     NOT NULL,
	Posicion     Char(1)     NULL,
	Nacionalidad Char(3)     NULL,

	-- Creacion de claves PK y FK
	Constraint PK_LBA_Jugadores Primary Key (Licencia),
	Constraint FK_LBA_Jugadores_Paises Foreign Key (Nacionalidad)
	REFERENCES LBA_Paises (ID) ON DELETE NO ACTION ON UPDATE CASCADE,

	-- Creacion de restricciones
	Constraint CK_RangoEdadJugadores CHECK ( YEAR(CURRENT_TIMESTAMP) - (YEAR(FechaNac)) BETWEEN 15 AND 50 ),
	Constraint CK_RangoDorsalJugadores CHECK ( Dorsal BETWEEN 0 AND 99 ),
	Constraint CK_RangoPosicionJugadores CHECK ( Posicion IN ('B', 'A', 'P', 'E', 'L') ),
)

-------------- CANCHAS ----------------
CREATE TABLE LBA_Canchas
(
	-- Creacion de columnas
	ID TinyInt IDENTITY(1,1) NOT NULL,
	Denominacion Varchar(30) NOT NULL,
	Direccion    Varchar(30) NULL,
	Localidad    Varchar(25) NOT NULL,

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Canchas Primary Key (ID),
)

-------------- EQUIPOS ----------------
-- RESTRICCIONES: 
   -- La fecha de fundación del equipo ha de ser anterior a la actual. (1)
CREATE TABLE LBA_Equipos
(
	-- Creacion de columnas
	ID Char(3) NOT NULL,
	Nombre Varchar(30) NOT NULL,
	Fecha_Fundacion DATE NULL,
	Localidad Varchar(25) NOT NULL,
	ID_Cancha TinyInt NOT NULL

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Equipos Primary Key (ID),
	Constraint FK_LBA_Equipos_Canchas Foreign Key (ID_Cancha)
	REFERENCES LBA_Canchas(ID) ON UPDATE CASCADE ON DELETE CASCADE,
	
	-- Creacion de restricciones
	Constraint CK_Limite_Fecha_Fundacion CHECK ( Fecha_Fundacion < CURRENT_TIMESTAMP ), -- (1)
)

-------------- PARTIDOS ----------------
-- RESTRICCIONES: Puntos_Local y Puntos_Visitante deben ser null para empezar el partido
CREATE TABLE LBA_Partidos
(
    -- Creacion de columnas
	ID SmallInt IDENTITY(1,1) NOT NULL,
	Fecha_Hora SmallDateTime NOT NULL,
	ID_Local Char(3) NOT NULL,
	ID_Visitante Char(3) NOT NULL,
	Puntos_Local TinyInt NULL,
	Puntos_Visitante TinyInt NULL,

	-- Creacion de claves PK y FK
    Constraint PK_LBA_Partidos Primary Key (ID),

	-- FK Equipos locales
	Constraint FK_LBA_Partidos_Equipos_locales Foreign Key (ID_Local)
	REFERENCES LBA_Equipos(ID),

	-- FK Equipos visitantes
	Constraint FK_LBA_Partidos_Equipos_visitantes Foreign Key (ID_Visitante)
	REFERENCES LBA_Equipos(ID),
)

-------------- JUEGA ----------------
-- RESTRICCIONES: 
   -- El número de minutos, si no es nulo, es positivo y menor que 40 (1)
CREATE TABLE LBA_Juega
(
	-- Creacion de columnas
	Licencia Char(10) NOT NULL,
	ID_Partido SmallInt NOT NULL,
	Minutos Int NULL,
	Tiros1 TinyInt NULL,
	Tiros2 TinyInt NULL,
	Tiros3 TinyInt NULL,
	Puntos1 TinyInt NULL,
	Puntos2 TinyInt NULL,
	Puntos3 TinyInt NULL,
	Personales TinyInt NULL,

	-- Creacion de claves PK y FK
	-- Clave primaria compuesta por las claves primarias de las 
	-- dos tablas que relaciona
	Constraint PK_LBA_Juega Primary Key (Licencia, ID_Partido),

	-- FK Partidos
	Constraint FK_LBA_Juega_Partidos Foreign Key (ID_Partido)
	REFERENCES LBA_Partidos(ID),

	-- FK Jugadores
	Constraint FK_LBA_Juega_Jugadores Foreign Key (Licencia)
	REFERENCES LBA_Jugadores(Licencia),

	-- Creacion de restricciones 
	Constraint CK_LimiteMinutosPartido CHECK ( Minutos BETWEEN 0 AND 40 ), -- (1)
)
