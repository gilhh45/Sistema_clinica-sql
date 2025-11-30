-- ==========================================================
-- PROJETO: SISTEMA DE GESTÃO DE CLÍNICA MÉDICA
-- TECNOLOGIAS: SQL, MySQL Workbench
-- OS CÓDIGOS DAS OUTRAS PARTES FORAM TRANSFERIDO PARA UM ÚNICO ARQUIVO
-- ==========================================================

-- 1. criação do banco de dados
create database grupo05;
use grupo05;

-- ==========================================================
-- SEÇÃO 2: DDL - CRIAÇÃO DA ESTRUTURA (TABELAS)
-- ==========================================================

-- tabela de especialidades
create table especialidades (
    id_especialidade int auto_increment primary key,
    nome_especialidade varchar(100) not null
);

-- tabela de convênios
create table convenios (
    id_convenio int auto_increment primary key,
    nome_convenio varchar(100) not null,
    tipo_plano varchar(100) not null
);

-- tabela de médicos (com chave estrangeira para especialidades)
create table medicos (
    id_medico int auto_increment primary key,
    nome_medico varchar(100) not null,
    crm varchar(20) unique not null, 
    celular varchar(20),
    id_especialidade int not null,
    foreign key (id_especialidade) 
        references especialidades(id_especialidade)
        on update cascade on delete restrict
);

-- tabela de pacientes (com chave estrangeira para convênios)
create table pacientes (
    id_paciente int auto_increment primary key,
    nome_paciente varchar(100) not null,
    data_nasc date not null,
    sexo char(1) not null, 
    id_convenio int not null,
    foreign key (id_convenio) 
        references convenios(id_convenio)
        on update cascade on delete restrict
);

-- tabela de consultas (tabela associativa/fato)
create table consultas (
    id_consulta int primary key,  
    data_cons date not null,
    hora time not null,
    status_consulta varchar(50),
    id_medico int not null,
    id_paciente int not null,
    foreign key (id_medico) references medicos(id_medico),
    foreign key (id_paciente) references pacientes(id_paciente)
);

-- tabela de pagamentos
create table pagamentos (
    id_pagamento int auto_increment primary key, 
    valor_pago decimal(10, 2) not null,           
    dt_pagamento date not null,
    forma_pag varchar(50) not null,
    id_consulta int not null,
    foreign key (id_consulta) 
        references consultas(id_consulta)
        on update cascade on delete restrict
);

-- ==========================================================
-- SEÇÃO 3: DML - INSERÇÃO DE DADOS (POPULAÇÃO)
-- ==========================================================

-- inserindo especialidades
insert into especialidades (nome_especialidade) values 
('Cardiologia'), ('Dermatologia'), ('Ortopedia'), ('Pediatria'), ('Ginecologia'),
('Oftalmologia'), ('Neurologia'), ('Psiquiatria'), ('Endocrinologia'), ('Urologia');

-- inserindo convênios
insert into convenios (nome_convenio, tipo_plano) values
('Unimed','Completo'), ('Bradesco_Saude','Basico'), ('SulAmerica','Executivo'),
('Amil','Familiar'), ('Particular','N/A'), ('Golden_Cross','Basico'),
('NotreDame','Empresarial'), ('Porto_Seguro','Completo'), ('Cassi','Funcionarios'),
('SUS','Publico');

-- inserindo médicos
insert into medicos (nome_medico, crm, celular, id_especialidade) values
('Dr_Roberto_Alves','12345-SP','(11)9999-1001',1),
('Dr_Julia_Silva','54321-SP','(11)9999-1002',2),
('Dr_Marcos_Paulo','99887-SP','(11)9999-1003',4),
('Dr_Ana_Beatriz','11223-SP','(11)9999-1004',3),
('Dr_Lucas_Mendes','33445-SP','(11)9999-1005',6),
('Dr_Fernanda_Lima','55667-SP','(11)9999-1006',2),
('Dr_Paulo_Coelho','77889-SP','(11)9999-1007',1),
('Dr_Carla_Dias','99001-SP','(11)9999-1008',5),
('Dr_Renato_Russo','22334-SP','(11)9999-1009',4),
('Dr_Patricia_Abravanel','44556-SP','(11)9999-1010',7);

-- inserindo pacientes
insert into pacientes (nome_paciente, data_nasc, sexo, id_convenio) values
('Ana Clara', '1990-05-12', 'F', 1),        
('Bruno Ferreira', '1985-08-22', 'M', 5),   
('Carlos Eduardo', '2015-02-10', 'M', 2),   
('Daniel Torres', '1978-11-30', 'M', 1),    
('Eliana Ramos', '1995-04-15', 'F', 3),     
('Fabio Jr', '1960-01-20', 'M', 4),         
('Gabriela Pugliesi', '1988-07-07', 'F', 5),
('Hugo Gloss', '1992-09-09', 'M', 2),        
('Ivete Sangalo', '1972-05-27', 'F', 1),    
('Jojo Todynho', '1997-02-11', 'F', 6);      

-- inserindo consultas
insert into consultas (id_consulta, data_cons, hora, status_consulta, id_medico, id_paciente) values
(5001, '2023-10-01', '08:00', 'Realizada', 1, 1),  
(5002, '2023-10-01', '09:00', 'Realizada', 2, 2),  
(5003, '2023-10-01', '10:00', 'Realizada', 3, 3),  
(5004, '2023-10-02', '08:00', 'Cancelada', 1, 4),  
(5005, '2023-10-02', '14:00', 'Realizada', 4, 5),  
(5006, '2023-10-03', '11:00', 'Realizada', 5, 1),  
(5007, '2023-10-03', '15:00', 'Agendada',  6, 6),  
(5008, '2023-10-04', '09:00', 'Realizada', 1, 7),  
(5009, '2023-10-04', '10:00', 'Agendada',  2, 8),  
(5010, '2023-10-05', '08:00', 'Realizada', 3, 3);  

-- inserindo pagamentos
insert into pagamentos (valor_pago, dt_pagamento, forma_pag, id_consulta) values
(150.00, '2023-10-01', 'Dinheiro', 5001),
(400.00, '2023-10-01', 'Cartão', 5002),
(100.00, '2023-10-01', 'Convenio', 5003),
(200.00, '2023-10-02', 'Pix', 5005),
(350.00, '2023-10-03', 'Cartão', 5006),
(400.00, '2023-10-04', 'Dinheiro', 5008),
(100.00, '2023-10-05', 'Convenio', 5010),
(50.00,  '2023-10-05', 'Taxa Extra', 5010),
(400.00, '2023-10-01', 'Pix', 5002),
(150.00, '2023-10-03', 'Convenio', 5001);

-- ==========================================================
-- SEÇÃO 4: DQL - CONSULTAS E RELATÓRIOS
-- ==========================================================

select * from especialidades;  /*1 Quais especialidades a clínica tem?*/

select nome_convenio, tipo_plano from convenios  /*2 Quais convênios são do tipo completo?*/
where tipo_plano = 'Completo';

select nome_medico,crm from medicos  /*3 Quais médicos tem a especialidade em cardiologia?*/  
where id_especialidade = 1;

select nome_paciente, data_nasc from pacientes /*4 Gostaria de saber a data de nascimento de pacientes que são apenas do sexo feminino?*/
where sexo='F';

select* from consultas /*5 Saber quais consultas que estão agendadas para o dia 1/10/2023 */
WHERE data_cons = '2023-10-01';

select * from pagamentos /*6 Quais pagamentos foram realizados em dinheiro? */
where forma_pag = 'Dinheiro';


/*2*/
select COUNT(*) AS total_pacientes_unimed /*Quantos pacientes tem o convênio Unimed?*/
from pacientes 
where id_convenio = 1;

select avg(valor_pago) AS media_valores   /*Qual é a média de valores pagos registrados
 na tabela de pagamentos?*/
from pagamentos;

select nome_paciente, data_nasc  /*Lista do nome e data de nascimento dos pacientes
                                   ordenados do mais velho para os mais novos*/
from pacientes 
order by data_nasc ASC;

/*3*/
select c.id_consulta, c.data_cons, p.nome_paciente /*Lista do id da consulta, 
													acompanhada com a data que ela vai ocorrer e o mome da paciente */
from consultas c
inner join pacientes p on c.id_paciente = p.id_paciente;


select m.nome_medico, e.nome_especialidade, c.hora /*Lista do nome de medicos, acompanhados com sua especialidade
													e o horário das suas consultas.*/
from consultas c
inner join medicos m ON c.id_medico = m.id_medico
inner join especialidades e ON m.id_especialidade = e.id_especialidade;


select p.nome_paciente, m.nome_medico, c.status_consulta/*Aqui apresenta o relatório dos status das consultas, acompanhado
 com o nome do paciente e do médico envolvidos nela.*/
from consultas c
inner join pacientes p ON c.id_paciente = p.id_paciente
inner join medicos m ON c.id_medico = m.id_medico;