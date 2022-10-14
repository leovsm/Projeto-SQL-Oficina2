-- Criação do banco de daods para o cenário de E-commerce
-- drop database ecommerce;
 create database oficina;
 use oficina;
 
-- Criar tabela Cliente
 create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    -- CPF char(11) not null,
    Contato varchar(30)
    -- constraint unique_cpf_client unique	(CPF)
);      
    
   
-- Criar tabela Carros
 create table cars(
	idCar int ,
    idCClient int,
    idPlaca varchar(9),
    Modelo varchar(45),
    Marca varchar (45),
    AnoModelo int,
    primary key (idCar, idClient),
    constraint fk_cars_client foreign key (idCClient) references clients(idClient)
   );
	
    
-- Criar tabela Equipe
 create table equipe(
	idEquipe int primary key,
    Setor int,
    Membros varchar(45)
   );
   
   
 -- Criar tabela Pedido
 create table orders(
	idOrder int auto_increment,
    idOrderClient int,
    idOCar int,
    idOEquipe int,
    Descricao varchar(255),
    Data_emissao date,
    primary key (idOrder, idOrderClient,idOCar),
    constraint fk_order_client foreign key (idOrder) references clients(idClient),
    constraint fk_order_car foreign key (idOrderClient) references cars(idOrderClient),
    constraint fk_order_client foreign key (idOCar) references clients(idClient)
    );
    
-- Criar tabela Peças
 create table pecas(
	idPecas int primary key,
    Nome varchar(255),
    Quantity varchar(255),
    ValorPeca float
   );
   
-- Criar tabela Peças no pedido
 create table pecasOS(
	idPecas int,
    idOrder int,
    Quantidade int,
    primary key (idPecas, idOrder),
    constraint fk_order_pecas foreign key (idPecas) references pecas(idPecas),
    constraint fk_order_orders foreign key (idOrder) references orders(idOrder)
   );
 
 
-- Criar tabela Serviços
 create table service(
	idService int primary key,
    Descricao varchar(255),
    Especialidade int not null,
    Valor float
   );
   
   -- Criar tabela Mecânicos
 create table specialists(
	idSpecialists int ,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    Especialidade int not null,
    Equipe int,
    primary key (idSpecialists, Especialidade,Equipe),
    constraint fk_specialist_service foreign key (Especialidade) references service(idService),
    constraint fk_specialist_equipe foreign key (Equipe) references equipe(idEquipe)
   );
       
-- Criar tabela Serviços no pedido
 create table serviceOS(
	idService int ,
    idOrder int,
    Quantity int,
    primary key (idService, idOrder),
    constraint fk_order_service foreign key (idService) references service(idService),
    constraint fk_order_orders foreign key (idOrder) references orders(idOrder)
   ); 
 
 
 
 
-- Criar tabela OS
 create table OS(
	idOS int,
    StatusOS enum('Em avalição','Aprovado','Realizando atividades','Completo'),
    Data_termino date,
    Valor float,
    idOrder int,
    idPecas int,
    idService int,
    primary key (idOS, idOrder,idPecas,idService),
    constraint fk_OS_pecas foreign key (idPecas) references pecas(idPecas),
    constraint fk_OS_orders foreign key (idOrder) references orders(idOrder),
    constraint fk_OS_service foreign key (idService) references service(idService)
   );
   

SELECT idOS, SUM (Valor) as ValorTotal
FROM OS
WHERE StatusOS <> 'Em avalição'
GROUP BY StatusOS
HAVING idPecas > 0;


SELECT * 
FROM clients as c
INNER JOIN  specialists as s on c.Fname = s.Fname
WHERE c.Lname=s.Lname;

