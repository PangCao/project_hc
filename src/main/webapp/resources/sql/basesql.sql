create database hcproject;

use hcproject;

create table if not exists member( 
	m_num varchar(30) primary key,
	m_password varchar(30) not null,
    m_name varchar(30) not null,
    m_position varchar(30),
    m_department varchar(30),
    m_tel varchar(50)
)default charset=utf8mb4;

select *from member;

insert into member values ('202207020001', '1234', '김현일', '사장', '사장', '010-2222-2222');
insert into member values ('202207020002', '1234', '이창기', '고문', '연구개발부', '010-1111-1111');
insert into member values ('202207020003', '1234', '김사원', '사원', '생산관리부', '010-3333-3333');
insert into member values ('202207020004', '1234', '김부장', '부장', '생산관리부','010-4444-4444');
insert into member values ('202207020005', '1234', '최여진', '사원', '인사부' , '010-5555-5555');

create table if not exists task (
	t_name varchar(30) primary key
)default charset=utf8mb4;

insert into task values 
	('가공'),
    ('소조립'),
    ('대조립'),
    ('선행의장'),
    ('블럭도장'),
    ('P.E'),
    ('탑재'),
    ('DOCK 의장'),
    ('진수 선행 도장'),
    ('진수');

create table if not exists project (
	pj_id varchar(30) primary key,
    pj_name varchar(50),
    pj_regdate datetime,
    pj_eta datetime,
    pj_task varchar(30),
    pj_progress float default 0.0,
    foreign key(pj_task) references task(t_name)
)default charset=utf8mb4;

insert into project values ('PJT-2022-0001', '유조선-01', '2022-07-20 14:37:10', '2023-12-31 11:59:59', '가공', '0.12');
insert into project values ('PJT-2022-0002', '여객선-01', '2022-07-19 14:37:10', '2024-12-31 11:59:59', '가공', '0.01');
insert into project values ('PJT-2022-0003', '컨테이너선-01', '2022-07-21 14:37:10', '2025-12-31 11:59:59', '가공', '0.9');
insert into project values ('PJT-2022-0004', '쇄빙유조선-01', '2022-07-24 14:37:10', '2024-02-10 10:12:59', '가공', '0.2');

create table if not exists remark(
	r_id int primary key auto_increment,
    r_title varchar(100) not null,
    r_content varchar(2000),
    r_anthor varchar(30),
    r_date datetime,
    r_view int default 0,
    r_class varchar(50) not null
)default charset=utf8mb4;

create table if not exists notice(
	n_id int primary key auto_increment,
    n_title varchar(100) not null,
    n_content varchar(2000),
    n_anthor varchar(30),
    n_date datetime,
    n_view int default 0
)default charset=utf8mb4;

create table if not exists product_management (
	p_num int auto_increment primary key,
    p_proname varchar(50) not null,
    p_tasknumber varchar(50),
    p_proccessnumber varchar(50),
    p_regdate datetime,
    p_startdate datetime,
    p_compledate datetime,
    p_remarkid int,
    p_regnum varchar(30),
    p_state varchar(50),
    foreign key(p_remarkid) references remark(r_id)
)default charset=utf8mb4;

create table if not exists out_product_management (
	op_num int auto_increment primary key,
    op_ordernumber varchar(40),
    op_proname varchar(50),
    op_comname varchar(50),
    op_regdate datetime,
    op_productname varchar(50),
    op_productstandard varchar(50),
    op_unit int,
    op_price int,
    op_regnum varchar(30),
    foreign key(op_regnum) references member(m_num)
)default charset=utf8mb4;