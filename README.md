"# Restaurant-Reservation-Management-System-Database-Project" 


## ERD

<img width="2380" height="1268" alt="Database ER diagram (crow's foot) (2)" src="https://github.com/user-attachments/assets/c7e976b7-1c52-49bd-9c31-196dd5f45058" />


# NOTES:
I made a M-M Table between Table and Reservation called ReservationTable, because one reservation could have many tables, and same table can be for many reservation at different time, and i've added status for reservation table to determine if its completed or not, (Confirmed) means that the reservation is still active (Not completed)

Another one that every restaurant have same table ids (1,2,3...) so i made a column tableId that represents the primary key, but it didn't present the actual id for the table itself inside the restaurant, So i made the primary key just for a column, not composite key because of simplicity of JOINS, and finally i made unique constraint for (TableNumber, RestaurantId) to solve this problem
