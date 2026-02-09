Create database Hotel_Reservation_Managment
use Hotel_Reservation_Managment

--1) craete tables Guests
create table guests
(
   id int primary key ,
   Fullname varchar(20) not null ,
   Nationalty varchar(30),
   passportNumber int,
   dateOfBirth date
);
--2) guest_contact_details
create table guestContactDetails
(
 guestId int,
 details varchar(300),
 primary key (guestId , details)
 --1) missing fk's
);
--3) reservation
Create table reservations
(
   id int primary key,
   bookingDate date,
   checkInDate date,
   checkOutDate date,
   reservation_status varchar(30),
   total_price varchar(5),
   numberOfAdults int,
   nuberOfChildren int
);
--4) hotels
create table hotels
(
   id int identity(1,1) primary key,
   name varchar(20) not null,
   address varchar(30),
   city varchar(30),
   starRate decimal (3,2), --2) missing check in constraint
   contactNumber varchar(15),
   managerId int --3) add constraint fk
);
--5) staff
create table staff
(
   id int identity primary key ,
   fullname varchar(30) not null,
   position varchar(30),
   salary decimal(5,3),
   hotelId int ,
   constraint hotelid_fK foreign key(hotelId) references hotels(id)
);
--6) services
create table [services]
(
   id int identity primary key  ,
   serviceName varchar(20) not null,
   charge varchar(30) ,
   requestDate date,
   staffId int references staff(id) 
);
--7) rooms
create table rooms
(
  roomNumber int primary key,
  roomType varchar(10),
  capacity int ,
  dailyRate int,
  availabillty int ,
  hotelId int foreign key references hotels(id)
);
--8) Amenities
create table Amenities
(
  Amenity varchar(20),
  roomNumber int foreign key references rooms(roomNumber),
  primary key(roomNumber , Amenity)
);
--9)reservations_Guest
create table reservations_Guest
(
   reservationId int,
   roomNumber int,
   primary key (reservationId , roomNumber ),
   constraint fk_reservationId foreign key (reservationId) references reservations(id),
   constraint fk_roomNumber foreign key (roomNumber) references rooms(roomNumber)
);
--10) payment
create table payments
(
   id int identity(1,1) primary key ,
   method varchar(20),
   amount decimal(4,4),
   configrationNumber int,
);
--11) reservation payment
create table reservation_payments
(
  reservationId int,
  paymentId int,
  primary key(reservationId ,paymentId),
  constraint fk_reservationId foreign key (reservationId) references reservations(id),
  constraint fk_paymentId foreign key (paymentId) references payments(id)
);
--12) reservation_services
create table reservation_services
(
  serviceId int ,
  reservationId int,
  primary key(serviceId,reservationId)
  -- 2)missing fk's
);
--13)
create table reservation_rooms
(
  reservationId int,
  roomNumber int ,
  primary key (reservationId , roomNumber)
  --3) missing fk's
);
--____________alteration_____________
--1)guestContactDetails
alter table guestContactDetails
add constraint fk_guestId foreign key (guestId) references guests(id)

--2)missing check in constraint hotels
alter table hotels 
add constraint check_constraint check(starRate In(3,4,5,6,7))
alter table hotels 
add constraint fk_id foreign key (managerId) references staff(id)
--3)reservation_services fk's
alter table reservation_services
add constraint fk_serviceId foreign key (serviceId) references [services](id)
alter table reservation_services
add constraint fk_reservationId foreign key (reservationId) references [reservations](id)

