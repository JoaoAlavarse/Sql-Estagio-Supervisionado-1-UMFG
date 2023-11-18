create table construction(
    id_construction serial primary key,
    company varchar(255) not null,
    cnpj char(14) not null,
    delivery_date date not null,
    start_date date not null,
    address varchar(255) not null,
    status varchar(15) not null
);

create table employee (
    id_employee serial primary key,
    name varchar(255) not null,
    cpf varchar(11) not null,
    phone varchar(20) not null,
    address varchar(255) not null,
    charge varchar(255) not null,
    gender varchar(10) not null,
    birth_date date not null
);


create table resource(
    id_resource serial primary key,
    name varchar(50) not null,
    brand varchar(20) not null,
    quantity int not null,
    type varchar(10) not null,
    observation varchar(150) null,
    purchase date not null
);

create table construction_employee(
    id_construction_employee serial,
    id_construction int not null,
    id_employee int not null,
    primary key (id_construction, id_employee, id_construction_employee)
);

create table allocation(
    id_allocation serial  primary key,
    id_construction int not null,
    id_resource int not null,
    allocation_date date not null,
    devolution_date date,
);

create table users(
    id_user serial  primary key,
    email varchar(150) not null,
    password varchar(12) not null
);

alter table employee
    add constraint employee_cpf_uq unique (cpf);


alter table construction alter status set default 'Em Analise';

alter table employee
    add constraint check_cpf
        check (cpf not like '%[^0-9]%' and length(cpf) = 11);

alter table construction
    add constraint check_cnpj
        check (cnpj not like '%[^0-9]%' and length(cnpj) = 14);

alter table resource
    add constraint check_quantity
        check (quantity >= 0);

alter table construction_employee
    add constraint fk_construction_employee_construction
        foreign key (id_construction) references construction(id_construction);

alter table construction_employee
    add constraint fk_construction_employee_employee
        foreign key (id_employee) references employee(id_employee);

alter table allocation
    add constraint fk_allocation_construction
        foreign key (id_construction) references construction(id_construction);

alter table allocation
    add constraint fk_allocation_resource
        foreign key (id_resource) references resource(id_resource);

alter table allocation
	add constraint check_dates
		check (devolution_date > allocation_date);