create database JA_Ayuntamientos
go
use JA_Ayuntamientos

create table Ayuntamientos
(
Nombre varchar(50)not null unique,
Provincia varchar(30)not null,
constraint PK_JA_Ayuntamientos primary key (Nombre)
)

create table Alcaldes
(
Nombre varchar(20) not null,
Apellidos varchar (40) not null,
DNI int not null unique,
[Fecha de alta] date,
Nombre_Ayuntamiento varchar(50) not null,
constraint PK_Alcalde primary key (DNI),
constraint FK_Alcalde_Ayuntamiento foreign key (Nombre_Ayuntamiento) references Ayuntamientos (Nombre)
on delete no action on update cascade
)

create table Secretarios
(
Nombre varchar(20) not null,
Apellidos varchar (40) not null,
DNI int not null unique,
[Fecha de alta] date,
Nombre_Ayuntamiento varchar(50) not null,
constraint PK_Secretarios primary key (DNI),
constraint FK_Secretarios_Ayuntamiento foreign key (Nombre_Ayuntamiento) references Ayuntamientos (Nombre)
on delete no action on update cascade
)