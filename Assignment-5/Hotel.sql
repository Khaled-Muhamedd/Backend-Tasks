use [Hotel_Reservation_Managment]


--Question 01 : 
--● If a hotel is deleted from the Hotels table, what is the appropriate 
--behavior for the rooms belonging to that hotel? Explain which 
--foreign key rule you would choose and why And Represent Rule
Alter Table rooms
Drop Constraint[FK__rooms__hotelId__44FF419A]
Alter Table rooms
Add Constraint Fk_Rooms_HotelId Foreign key (hotelId) References hotels(hotelId)
On Delete  Cascade On Update Cascade

--Question 02 : 
--● When a room is deleted from the Rooms table, what should 
--happen to the related records in Amenities? Which rule makes the 
--most sense for this relationship, and why? And Represent Rule 
Alter Table Amenities
Drop Constraint[FK__Amenities__roomN__47DBAE45]
Alter Table Amenities
Add Constraint [FK_RoomNumber] Foreign key (roomNumber) References rooms(roomNumber)
On Delete set Null On Update set Null

--Question 03 : 
--● If a staff member’s ID changes, what impact should this have on 
--the Services they are linked to? Which update rule is most 
--suitable? And Represent Rule
Alter Table [services]
Drop Constraint [FK__services__staffI__4222D4EF]
Alter Table [services]
Add Constraint FK_StaffId Foreign key (staffId) References staff(id)
on Delete set Default on Update set Default