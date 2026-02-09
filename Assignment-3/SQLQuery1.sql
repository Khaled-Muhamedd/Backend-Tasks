Use OnlineRetailStore
--                                     ____________________________________
-- 1) Supplier                        __________ create Tables______________
Create Table suppliers
(
   id int Primary Key ,
   [Name] varChar(40) Not Null,
   Country varChar(40),
   Email varchar(30) Unique,
   [Address] varChar(60),
   ---add missing contact--- 
);
---- 2)Customers
Create Table Customers
(
   CustomerId int identity(1,1) Primary Key,
   FullName varChar(30) Not Null,
   PhoneNumber varChar(20),
   Email varChar(60) Unique,
   ShippingAddress varChar(100),
   RegisterationDate Date,
)
---- 3) Payments
Create Table Payments
(
   PaymentsId int Identity(1,1) Primary Key,
   PaymentDate Date, 
   Amount varChar(6),
  [Status] varChar(20), ---choosing 
  Method varChar(50) ---choosing
);
----4) Reviews
Create Table Reviews
(
   ReviewId int Primary Key,
   Rating int Not Null,
   [Date] Date,
   Comment varChar(50),
   CustomerId int
   Constraint CustomerId_FK Foreign Key(CustomerId) References Customers(CustomerId)
   ---Add another Constraint product_id => Product(id)
)
---- 5) ProductsS 
Create Table Products
(
   productId int identity(1,1),
   StockQuantity int Not Null,
   [Name] varChar(40) Not Null,
   AddedDate Date Not Null,
   [Description] varChar(200),
   UnitPrice varChar(8),
   CatogeryId int ----add constraint FK => catogries Table
)
--- 6) Orders
Create Table Orders
(
  OrderId int identity(1,1) Primary Key,
  Status varChar(30),
  TotalAmount varChar(4),
  OrderDate Date,
  customerId int,
  Constraint customerId_FK Foreign Key(customerId) References Customers(CustomerId)
);
--- 7) shipments
Create Table Shipments
(
   ShipmentId int identity(1,1) Primary Key,
   ShipmentDate Date ,
   [Status] varChar(10), --choose by Check 
   DeliveryDate Date,
   CarrierName varChar(20),
   TrackingNumber int Unique
   oredrId int References Orders(OrderId),
);
--add constraint Primary Key to product table
Alter Table Products
Add Constraint ProductId_pk Primary Key(productId)
--- 8) orderItems
Create Table OrderItmes
(
   OrderItemId int identity(1,1) Primary Key,
   Quantity varChar(5),
   UnitPrice varChar(5),
   productId int,
   Constraint productId_FK Foreign Key(productId) References Products(productId),
   orderId int,
   Constraint orderId_FK Foreign Key (orderId) References Orders(OrderId)
);
--- 9)Catogries
Create Table Categories
(
   CategoryId int Primary Key,
   [Name] varChar(30) Not Null,
   [Description] varChar(500),
   MainCategory int References Categories(CategoryId)
)
--- 10) stockTransAction
Create Table StockTransAction
(
  TranId int Primary Key,
  TranDate Date,
  QuantittyChange int,
  [Type] varChar(10) Not Null,
  Reference varChar(30),
  productId int References Products(ProductId)
);
--- 11) Create products_supplier
Create Table Products_suppliers
(
   supplierId int,
   productId int,
   primary key(supplierId,productId)
   ---missing constraint for 2 fk
);
--- 12) Create orders_payments

Create Table Order_Payments
(
   orderId int,
   paymentId int,
   primary key(orderId,paymentId),
   Constraint orderId_FK Foreign Key(orderId) References Orders(OrderId),
);
