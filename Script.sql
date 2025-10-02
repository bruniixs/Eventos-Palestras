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
    foreign key (Id_palestras) references tbEventos(Id_evento),
    foreign key (Id_palestras) references tbPalestrantes(Id_palestrante),
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
	in p_nome varchar(50),
    in p_email varchar(100),
    in p_senha_hash varchar(255),
    in p_role varchar(20) 
)
begin
	insert into tbUsuarios (Nome, Email, Senha_hash, Role, Ativo, Data_criacao)
    values (p_nome, p_email, p_senha_hash, p_role, 1, now());
end $$

delimiter ;

delimiter $$