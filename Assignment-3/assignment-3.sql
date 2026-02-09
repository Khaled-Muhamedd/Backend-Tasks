Create database online_retail_store
use online_retail_store;

---Create Tables  
--1)supplier
Create table suppliers
(
  id int primary key,
  name varchar(30),
  category varchar(40), --1) check constraint()
  email varchar(50),
  [address] varchar(40),
  contactNumber varchar(15)
);
---2) customers
create table customers
(
  id int identity(1,1) primary key,
  FullName varchar(30),
  phoneNumber varchar(15),
  Email varchar(30),
  shippingAddress varchar(20),
  RegerationDate date,
);
--3) payment
Create table payments
(
  id int identity primary key,
  Payment_date Date,
  amount int ,
  [status] varchar(20) check([status] in('Good','Excelent','Not_bad','bad') ),
  method varchar(30) check(method in ('Cash', 'visa'))
);
---4) order
create table orders
(
  id int primary key,
  status varchar(20), --- 2) check
  total_amont varchar(4),
  order_date date,
  customer_id int Foreign key References customers(id)
);
---5) shipmetns
Create table shipments
(
  id int identity(1,1) primary key,
  shipment_date date,
  status varchar(20),
  delivery_date date,
  carrier_name varchar(20) not null,
  tracking_number int unique,
  order_id int Foreign key References orders(id)
);
---6) categories
Create table categories
(
  id int primary key ,
  name varchar(20) not null,
  description varchar(300),
  Main_category int Foreign key References categories(id)
);
---7)  products
Create table products
(
  id int identity(1,1) primary key,
  stock_quantity int,
  name varchar(20) not null,
  added_date date,
  description varchar(300),
  unit_price varchar(4),
  catoegry_id int Foreign Key References categories(id)
);
--8) stckTransaction
Create table stoc_transactions
(
  id int primary key,
  tran_date date,
  quantity_change int,
  type varchar, -- 3) check
  [references] varchar(20),
  product_id int,
  constraint produc_id_FK foreign key (product_id) References products(id)
);
--- 9) Reviews
Create table reviews
(
  id int identity(1,1) primary key,
  date date,
  comment varchar(200),
  product_id int foreign key References products(id),
  customer_id int, --4) add constraint foreign key
);
-- 10) order_item
Create table order_items
(
  id int identity(1,1) primary key,
  quanitiy int,
  price varchar(4),
  product_id int foreign key References products(id),
  order_id int foreign key References orders(id),
);
--- 11) orders_payment
Create table orders_payments
(
  order_id int,
  payment_id int,
  primary key(order_id, payment_id), --composite pk
  constraint FK_order_id foreign key(order_id) References orders(id),
  constraint FK_payment_id foreign key (payment_id) References payments(id)
);
--12) products_suppliers
Create table product_suppliers
( 
  supplier_id int,
  product_id int ,
  primary key(supplier_id , product_id),
  constraint FK_supplier_id foreign key(supplier_id) References suppliers(id)
  -- 5) missing foreign key constraint
);
----alter colunms
--1) supplier
alter table suppliers
add constraint check_constraint check(category in('Local','International','Partner'));

alter table suppliers
add constraint default_constraint default 'Local' For category; 
--2) orders
alter table orders
add constraint check_constraint_for_status check([status] in('Pending','Shipped','Delivered','Cancelled'))
--3) stock_transaction
alter table stoc_transactions
add constraint check_constraint_for_type check(type in('In','Out','Transfer'));
--4) reviews
alter table reviews
add constraint FK_constraint_customer_id foreign key(customer_id) References customers(id);
--5) add foreing key for table product_suppliers to colunm product_id
alter table product_suppliers
add constraint Fk_product_id foreign key (product_id) References products(id);

--__________create schemas & transfer tables in it____________ 
---1) partners
Go
Create schema partners
--2) sales
Go
Create schema sales
--3) catalogs
Go
Create schema [catalog]
Go
--4) inventory
Create schema inventory
Go
--5)logitics
Create schema logitics
Go

--___________transfer tabels to schemas_______________
--1) transfer suppliers & customers to partners
alter schema partners Transfer dbo.suppliers
Go
alter schema partenrs Transfer dbo.customers
Go
--2) transfer categories to catalog
alter schema [catalog] Transfer dbo.categories
Go
--3) transfer products, stock_transactions, product_suppliers to inventory
alter schema inventory Transfer dbo.products
Go
alter schema inventory Transfer dbo.stoc_transactions
Go
alter schema inventory Transfer dbo.product_suppliers
Go
--4) transfer orders, order_items, payments, orders_payments, reviews to sales
alter schema sales Transfer dbo.orders
Go
alter schema sales Transfer dbo.order_items
Go
alter schema sales Transfer dbo.payments
Go
alter schema sales Transfer dbo.orders_payments
Go
alter schema sales Transfer dbo.reviews
Go
--5) transfer shipments to logitics
alter schema logitics Transfer dbo.shipments

