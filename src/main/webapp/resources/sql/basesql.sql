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

create table if not exists out_company_list (
	o_id int primary key auto_increment,
    o_name varchar(50),
    o_task varchar(30),
    foreign key(o_task) references task(t_name)
)default charset=utf8mb4;

insert into out_company_list(o_name, o_task) values ('OutCompany', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('OutCom', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('Outpany', 'A(가공)');
insert into out_company_list(o_name, o_task) values ('Company', 'B(소조립)');
insert into out_company_list(o_name, o_task) values ('OCompany', 'C(대조립)');
insert into out_company_list(o_name, o_task) values ('aaCompany', 'D(선행의장)');
insert into out_company_list(o_name, o_task) values ('bbqCompany', 'E(블럭도장)');


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

create table if not exists projectcreate(
	pc_num int auto_increment primary key,
	pc_id varchar(30),
    pc_name varchar(50),
    pc_tasknumber varchar(50),
    pc_propart varchar(30),
    pc_dpn varchar(30)
)default charset=utf8mb4;

select * from projectcreate;
select * from projectcreate where pc_id = 'PJT-2022-0001';
