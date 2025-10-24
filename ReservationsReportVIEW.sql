CREATE VIEW ReservationsReport AS
SELECT r.Id, re.Id AS 'RestaurantId', re.Name, re.Address, c.Id AS 'CustomerId', CONCAT(c.FirstName, ' ' ,c.LastName) AS CustomerName
FROM Reservations r
JOIN Restaurants re
ON r.RestaurantId = re.Id
JOIN Customers c
ON r.CustomerId = c.Id;

SELECT * FROM ReservationsReport;