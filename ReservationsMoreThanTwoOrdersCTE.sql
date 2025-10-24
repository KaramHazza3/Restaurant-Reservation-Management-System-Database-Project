WITH CTE_ReservationsMoreThanTwoOrders 
AS (
	SELECT r.Id, COUNT(o.Id) As OrderCount
	FROM Reservations r
	JOIN Orders o
	ON r.Id = o.ReservationId
	GROUP BY r.Id
	HAVING COUNT(o.Id) >= 2
)

SELECT * FROM CTE_ReservationsMoreThanTwoOrders;