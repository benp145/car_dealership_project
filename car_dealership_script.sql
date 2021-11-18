-- create tables: 

CREATE TABLE "car" (
  "car_id" serial primary key,
  "make" varchar(50),
  "model" varchar(50),
  "year" int,
  "serial_number" varchar(50),
  "new" boolean,
  "for_sale" boolean,
  "last_service" date
);

CREATE TABLE "sales_person" (
  "sales_person_id" serial primary key,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "email" varchar(50)
);

CREATE TABLE "customer" (
  "customer_id" serial primary key,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "email" varchar(50)
);

CREATE TABLE "invoice" (
  "invoice_id" serial primary key,
  "car_id" int,
  "customer_id" int,
  "sales_person_id" int,
  "date" date,
  "price" float
);

CREATE TABLE "mechanic" (
  "mechanic_id" serial primary key,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "email" varchar(50),
  "rate" float
);

CREATE TABLE "part" (
  "part_id" serial primary key,
  "name" varchar(50),
  "price" float
);

CREATE TABLE "service_ticket" (
  "ticket_id" serial primary key,
  "car_id" int,
  "customer_id" int,
  "description" text,
  "date" date,
  "price" float
);

CREATE TABLE "service_mechanic" (
  "service_id" serial primary key,
  "mechanic_id" int,
  "ticket_id" int,
  "hours" time
);

CREATE TABLE "parts_used" (
  "use_id" serial primary key,
  "part_id" int,
  "ticket_id" int
);

-- adding foreign keys:

ALTER TABLE "invoice" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("sales_person_id") REFERENCES "sales_person" ("sales_person_id");

ALTER TABLE "service_ticket" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");

ALTER TABLE "service_ticket" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "service_mechanic" ADD FOREIGN KEY ("mechanic_id") REFERENCES "mechanic" ("mechanic_id");

ALTER TABLE "service_mechanic" ADD FOREIGN KEY ("ticket_id") REFERENCES "service_ticket" ("ticket_id");

ALTER TABLE "parts_used" ADD FOREIGN KEY ("part_id") REFERENCES "part" ("part_id");

ALTER TABLE "parts_used" ADD FOREIGN KEY ("ticket_id") REFERENCES "service_ticket" ("ticket_id");


-- adding data:
-- customers:

insert into customer(first_name, last_name, email)
values('Makayla', 'Fowler', 'mfowler@mail.com');

insert into customer(first_name, last_name, email)
values('Dylan', 'Bonilla', 'bonzilla@mail.com');

insert into customer(first_name, last_name, email)
values('Jamir', 'Herrera', 'jherrera@mail.com');

insert into customer(first_name, last_name, email)
values('Moriah', 'Rhodes', 'mrhodes@mail.com');

insert into customer(first_name, last_name, email)
values('Olivia', 'Collier', 'ocollier@mail.com');

insert into customer(first_name, last_name, email)
values('Jaylin', 'Howard', 'jhoward@mail.com');

insert into customer(first_name, last_name, email)
values('Turner', 'Sanchez', 'tsanchez@mail.com');

insert into customer(first_name, last_name, email)
values('Roberto', 'Enwig', 'renwig@mail.com');

insert into customer(first_name, last_name, email)
values('Demarion', 'Lindsey', 'dlindsey@mail.com');

insert into customer(first_name, last_name, email)
values('Fernanda', 'Meadows', 'fmeadows@mail.com');

insert into customer(first_name, last_name, email)
values('Maia', 'Riley', 'mriley@mail.com');

insert into customer(first_name, last_name, email)
values('Elaine', 'Solis', 'esolis@mail.com');

-- sales:


insert into sales_person(first_name, last_name, email)
values('Evelin', 'Pacheco', 'epacheco@mail.com');

insert into sales_person(first_name, last_name, email)
values('Jaylon', 'Clark', 'jclark@mail.com');

insert into sales_person(first_name, last_name, email)
values('Anya', 'Forbes', 'aforbes@mail.com');

insert into sales_person(first_name, last_name, email)
values('Jakayla', 'Shepard', 'jshepard@mail.com');

insert into sales_person(first_name, last_name, email)
values('Kaila', 'Huffman', 'khuffman@mail.com');

insert into sales_person(first_name, last_name, email)
values('Kassidy', 'Miles', 'kmiles@mail.com');

-- mechanics:

insert into mechanic (first_name, last_name, email, rate)
values('Yareli', 'Wilson', 'ywilson@mail.com', 15.97);

insert into mechanic (first_name, last_name, email, rate)
values('Derrick', 'Booker', 'dbooker@mail.com', 15.97);


insert into mechanic (first_name, last_name, email, rate)
values('Frankie', 'Watson', 'fwatson@mail.com', 16.03);

insert into mechanic (first_name, last_name, email, rate)
values('Davin', 'Hansen', 'dhansen@mail.com', 15.47);
select * from mechanic m 

-- cars: 
create or replace function add_car(
	_make varchar,
	_model varchar,
	_year int,
	_vin varchar
)

returns record as $main$

declare
	new_car record;
begin
	insert into car(make, model, year, serial_number, "new", for_sale)
	values(_make, _model, _year, _vin, false, false)
	returning *
	into new_car;

	return new_car;
end;
$main$
language plpgsql;

create or replace procedure newCar (
	_car_id int
)
language plpgsql
as $$
begin 
	update car 
	set new = true, for_sale = true 
	where car_id = _car_id;
	commit;
end;
$$

select add_car('Toyota', '4Runner', 2022, 'WBACB4324RFL14401');
select add_car('Toyota', '4Runner', 2022, 'JTLKE50E581048963');
select add_car('Toyota', '4Runner', 2022, '1FVABPAL91HH92692');
select add_car('Toyota', '4Runner', 2022, 'JH4KA4640LC001187');
select add_car('Toyota', '4Runner', 2022, '4F4ZR17V7XTM07477');
select add_car('Toyota', 'Corolla', 2022, 'JH4KA4650KC031815');
select add_car('Toyota', 'Corolla', 2022, '3D4GG47B09T581222');
select add_car('Toyota', 'Corolla', 2022, '1J4BA3H10AL171412');
select add_car('Toyota', 'Corolla', 2022, 'SALVT2BG1CH654491');
select add_car('Toyota', 'Corolla', 2022, '2D4FV47V46H368760');
select add_car('Toyota', 'RAV4', 2022, '1JCMR7841JT185472');
select add_car('Toyota', 'RAV4', 2022, '1HD1PDC392Y952267');
select add_car('Toyota', 'RAV4', 2022, '1G8MG35X48Y106575');
select add_car('Toyota', 'RAV4', 2022, '2D4FV47V46H368760');
select add_car('Toyota', 'RAV4', 2022, '1G3NF52E3XC403652');
select add_car('Toyota', 'Camry', 2022, '3C8FY68B72T322831');
select add_car('Toyota', 'Camry', 2022, 'JH4DB1650PS000680');
select add_car('Toyota', 'Camry', 2022, '3D4GG47B09T581222');
select add_car('Toyota', 'Camry', 2022, '2T1BR18E5WC056406');
select add_car('Toyota', 'Camry', 2022, '2T1BR18E5WC056406');
call newcar(1);
call newcar(2);
call newcar(3);
call newcar(4);
call newcar(5);
call newcar(6);
call newcar(7);
call newcar(8);
call newcar(9);
call newcar(10);
call newcar(11);
call newcar(12);
call newcar(13);
call newcar(14);
call newcar(15);
call newcar(16);
call newcar(17);
call newcar(18);
call newcar(19);
call newcar(20);
select * from car c; 


-- purchase car:
create or replace procedure purchaseCar (
	_customer_id int,
	_sales_person_id int,
	_car_id int,
	_date_sold date
)
language plpgsql
as $$
begin 
	insert into invoice(car_id, customer_id, sales_person_id, "date", price)
	values(_car_id, _customer_id, _sales_person_id, _date_sold, 10000.00);
	update car 
	set for_sale = false, last_service = _date_sold
	where car_id = _car_id;
	commit;
end;
$$

call purchasecar(1, 3, 5, '2021-11-9');
call purchasecar(2, 3, 18, '2021-11-10');
call purchasecar(3, 1, 2, '2021-11-14');
call purchasecar(4, 6, 18, '2021-11-14');
call purchasecar(5, 5, 11, '2021-11-15');
call purchasecar(6, 6, 9, '2021-11-15');
call purchasecar(7, 3, 4, '2021-11-16');
call purchasecar(8, 2, 8, '2021-11-16'); 

select * from invoice i ;
select * from car c 
where for_sale = false;

-- car parts

insert into part(name, price)
values('Alternator', 150);

insert into part(name, price)
values('Air Filter', 25);


insert into part(name, price)
values('Serpentine Belt', 45);

insert into part(name, price)
values('Battery', 100);



-- service car

create or replace procedure serviceCar(
	_car_id	int,
	_customer_id int,
	_description text,
	_date_serviced date
)
language plpgsql
as $$
begin 
	insert into service_ticket(car_id, customer_id, description, "date", price)
	values(_car_id, _customer_id, _description, _date_serviced, 50); -- 50 dollar flat rate
	update car 
	set last_service = _date_serviced
	where car_id = _car_id;
end;
$$;

-- can't quite get these next two procedures to work :/
create or replace procedure addMechanicCost (
	_ticket_id int
)
language plpgsql
as $$
begin 
	update service_ticket 
	set price = price + (select cost_mech
		from
		(
			select distinct ticket_id, sum(hours * mechanic.rate) as cost_mech
			from service_mechanic
			join mechanic on service_mecahnic.mechanic_id = mechanic.mechanic_id 
			group by ticket_id
		) as prices
	)
	where ticket_id = _ticket_id;
	
	
	commit;
end;
$$;

create or replace procedure addPartCost (
	_ticket_id int
)
language plpgsql
as $$
begin 
	update service_ticket 
	set price = price + (select total_cost
		from
		(
			select distinct ticket_id, sum(price) as total_cost
			from part
			join parts_used on part.part_id = part_used.part_id 
			group by ticket_id 
		) as prices
		where ticket_id = _ticket_id )
	where ticket_id = _ticket_id;
	
	
	commit;
end;
$$;

select add_car('Honda', 'Accord', 2003, 'JH4NA1260NT000255');
select add_car('Honda', 'CRV', 2014, '3D7UT2CL2BG587350');
select add_car('Ford', 'Fusion', 2009, 'JH4KA3151KC019450');
select add_car('Chevy', 'Tahoe', 1999, '1FVACWDU1BHBB3474');

call servicecar(21, 9, 'Oil change', '2021-11-4');

insert into service_mechanic(mechanic_id, ticket_id, hours)
values(3, 3, '00:40:23');

call servicecar(22, 10, 'Replaced alternator and serpentine belt', '2021-11-10');

insert into service_mechanic(mechanic_id, ticket_id, hours)
values(2, 4, '01:00:31');

insert into service_mechanic(mechanic_id, ticket_id, hours)
values(1, 4, '00:22:00');

insert into parts_used(part_id, ticket_id)
values(1, 4);


insert into parts_used(part_id, ticket_id)
values(4, 4);



select * from part p 

select * from service_mechanic sm 

select * from parts_used pu 

select * from service_ticket st 

call addpartcost(3);
call addpartcost(4);
call addmechaniccost(3);
call addmechaniccost(4); 














-- bottom of script