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
   ('A(가공)'),
    ('B(소조립)'),
    ('C(대조립)'),
    ('D(선행의장)'),
    ('E(블럭도장)'),
    ('F(P.E)'),
    ('G(탑재)'),
    ('H(DOCK의장)'),
    ('I(진수선행도장)'),
    ('J(진수)');

create table if not exists project (
	pj_id varchar(30) primary key,
    pj_name varchar(50),
    pj_regdate datetime,
    pj_eta datetime,
    pj_task varchar(30) default 'A(가공)',
    pj_progress float default 0.0,
    foreign key(pj_task) references task(t_name)
)default charset=utf8mb4;

select * from project;
select distinct pj_id, pj_name from project;

insert into project values ('PJT-2022-0001', '유조선-01', '2022-07-20 14:37:10', '2023-12-31 11:59:59', 'A(가공)', '0.12');
insert into project values ('PJT-2022-0002', '여객선-01', '2022-07-19 14:37:10', '2024-12-31 11:59:59', 'A(가공)', '0.01');
insert into project values ('PJT-2022-0003', '컨테이너선-01', '2022-07-21 14:37:10', '2025-12-31 11:59:59', 'A(가공)', '0.9');
insert into project values ('PJT-2022-0004', '쇄빙유조선-01', '2022-07-24 14:37:10', '2024-02-10 10:12:59', 'A(가공)', '0.2');

create table if not exists remark(
	r_id int primary key auto_increment,
    r_title varchar(100) not null,
    r_content varchar(2000),
    r_anthor varchar(30),
    r_date datetime,
    r_view int default 0,
    r_class varchar(50) not null,
    r_anthor_id varchar(30),
    foreign key(r_anthor_id) references member(m_num)
)default charset=utf8mb4;

create table if not exists remark_project(
	rp_num int primary key auto_increment,
    rp_r_id int,
    rp_proid varchar(50),
    rp_task varchar(30),
    rp_process varchar(50),
    foreign key(rp_r_id) references remark(r_id),
    foreign key(rp_proid) references project(pj_id)
)default charset=utf8mb4;

select * from remark_project;


create table if not exists notice(
	n_id int primary key auto_increment,
    n_title varchar(100) not null,
    n_content varchar(2000),
    n_anthor varchar(30),
    n_date datetime,
    n_view int default 0,
    n_anthor_id varchar(30),
    foreign key(n_anthor_id) references member(m_num)
)default charset=utf8mb4;

select * from notice;

create table if not exists product_management (
	p_num int auto_increment primary key,
    p_proid varchar(30),
    p_tasknumber varchar(50),
    p_processnumber varchar(50),
    p_regdate datetime,
    p_startdate datetime,
    p_compledate datetime,
    p_remarkid varchar(200),
    p_regnum varchar(30),
    p_state varchar(50)
)default charset=utf8mb4;

select * from product_management;


select * from project;

create table if not exists out_company_list (
	o_id int primary key auto_increment,
    o_name varchar(50),
    o_task varchar(30),
    foreign key(o_task) references task(t_name)
)default charset=utf8mb4;

select * from notice;

insert into out_company_list(o_name, o_task) values ('OutCompany', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('OutCom', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('Outpany', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('Company', 'B(소조립)');
insert into out_company_list(o_name, o_task) values ('OCompany', 'C(대조립)');
insert into out_company_list(o_name, o_task) values ('aaCompany', 'D(선행의장)');
insert into out_company_list(o_name, o_task) values ('bbqCompany', 'E(블럭도장)');
select * from out_company_list;

create table if not exists out_company_progress (
	ocp_id int primary key auto_increment,
    ocp_comid int,
    ocp_ordernum int,
    ocp_name varchar(50),
    ocp_progress varchar(30),
    foreign key(ocp_comid) references out_company_list(o_id)
)default charset=utf8mb4;

insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 1, 'OutCompany', '의뢰수락대기');
insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 2, 'OutCompany', '의뢰수락대기');
insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 1, 'OutCompany', '의뢰수락대기');
insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 2, 'OutCompany', '의뢰수락대기');
insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 3, 'OutCompany', '의뢰수락대기');
insert into out_company_progress(ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values (1, 1, 'OutCompany', '의뢰수락대기');

select * from out_company_progress;

create table if not exists out_product_management (
	op_num int auto_increment primary key,
    op_ordernumber varchar(40),
    op_proid varchar(30),
    op_comid int,
    op_regdate datetime,
    op_productname varchar(50),
    op_productstandard varchar(50),
    op_unit int,
    op_price int,
    op_regnum varchar(30),
    foreign key(op_regnum) references member(m_num),
    foreign key(op_proid) references project(pj_id),
    foreign key(op_comid) references out_company_list(o_id)
)default charset=utf8mb4;

insert into out_product_management(op_ordernumber, op_proid, op_comid, op_regdate, op_productname, op_productstandard, op_unit, op_price, op_regnum) values
('OT-001', 'PJT-2022-0001', 2, '2022-07-21 12:10:20', 'xxx001', 'xl-01', 100, 300000, "202207020001");
insert into out_product_management(op_ordernumber, op_proid, op_comid, op_regdate, op_productname, op_productstandard, op_unit, op_price, op_regnum) values
('OT-002', 'PJT-2022-0002', 1, '2022-07-21 12:10:20', 'xxx001', 'xl-01', 100, 300000, "202207020003");
insert into out_product_management(op_ordernumber, op_proid, op_comid, op_regdate, op_productname, op_productstandard, op_unit, op_price, op_regnum) values
('OT-001', 'PJT-2022-0003', 3, '2022-07-21 12:10:20', 'xxx001', 'xl-01', 100, 300000, "202207020002");

select * from out_product_management;

create table if not exists projectcreate(
	pc_num int auto_increment primary key,
	pc_id varchar(30),
    pc_name varchar(50),
    pc_tasknumber varchar(50),
    pc_propart varchar(30),
    pc_dpn varchar(30)
)default charset=utf8mb4;

select * from projectcreate;
select count(distinct pc_id) from projectcreate where pc_id like '%-2022-%';
select * from projectcreate where pc_num;
