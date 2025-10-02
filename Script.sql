create database dbEventos_Palestras;
use dbEventos_Palestras;

-- TABELAS 
create table tbEventos(
	Id_evento int primary key auto_increment,
    Nome_evento varchar(100) not null,
    Data_evento date not null,
	Data_Criacao datetime default current_timestamp 
);

create table tbPalestrantes(
	Id_palestrante int primary key auto_increment,
    Nome_palestrante varchar(50) not null,
    Area_palestrante varchar(100) not null,
	Data_Criacao datetime default current_timestamp 
);

create table tbPalestras(
	Id_palestras int primary key auto_increment,
    Id_evento int,
    Id_palestrante int,
    foreign key (Id_evento) references tbEventos(Id_evento),
    foreign key (Id_palestrante) references tbPalestrantes(Id_palestrante),
	Data_Criacao datetime default current_timestamp 
);

create table tbUsuarios(
	Id_usuarios int primary key auto_increment,
    Nome varchar (50) not null,
    Email varchar(100) not null,
    Role enum ("Adm", "Gerente", "Comum") not null,
    Senha_hash varchar (255),
    Ativo tinyint (1) default 1,
    Data_Criacao datetime default current_timestamp 
);


-- INSERTS 

delimiter $$ 

drop procedure if exists sp_usuario_criar $$

create procedure sp_usuario_criar
(
	in a_nome varchar(50),
    in a_email varchar(100),
    in a_senha_hash varchar(255),
    in a_role varchar(20) 
)
begin
	insert into tbUsuarios (Nome, Email, Senha_hash, Role, Ativo, Data_criacao)
    values (a_nome, a_email, a_senha_hash, a_role, 1, now());
end $$

delimiter ;

delimiter $$

drop procedure if exists sp_evento_criar $$

create procedure sp_evento_criar
(
	in b_nome varchar(50),
    in b_data date
)
begin 
	insert into  tbEventos (Nome_evento, Data_evento)
    values (b_nome, b_data, now());
end $$

delimiter ;

delimiter $$

drop procedure if exists sp_palestrante_criar $$

create procedure sp_palestrante_criar 
(
	in c_nome varchar(50),
    in c_area varchar(100)
)
begin 
	insert into tbPalestrantes (Nome_palestrante, Area_palestrante)
    values (c_nome, c_area, now());
end $$

delimiter ;

-- SELECTS 

delimiter $$ 

drop procedure if exists sp_evento_listar $$

create procedure sp_evento_listar ()
begin
	select 
		Id_evento,
        Nome_evento from tbEventos order by Nome_evento;
end $$

delimiter ;

delimiter $$ 

drop procedure if exists sp_palestrante_listar $$

create procedure sp_palestrante_listar()
begin
	select 
        Id_palestrante,
        Nome_palestrante from tbPalestrante order by Nome_palestrante;
end $$

delimiter ;

delimiter $$

drop procedure if exists sp_palestra_listar $$

create procedure sp_palestra_listar()
begin
	select
		e.Id_palestra
        e.Data_criacao
		e.Id_evento as evento_palestra,
        e
        
        from tbPalestra e
        left join tbEvento a on a.Id_evento = e.Id
		




