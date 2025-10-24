CREATE PROCEDURE sp_ReservedTablesReport
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	
	SELECT re.Id AS ReservationId, r.Id AS RestaurantId, r.Name AS RestaurantName, t.TableNumber, rt.AssignedSeats, re.PartySize, rt.CreatedAt AS ReservedAt
	FROM ReservationTable rt
	JOIN Reservations re
	ON rt.ReservationId = re.Id
	JOIN Restaurants r
	ON r.Id = re.RestaurantId
	JOIN Tables t
	ON t.Id = rt.TableId
	WHERE Status = 'Confirmed' AND rt.CreatedAt >= @StartDate AND rt.CreatedAt <= @EndDate;

END;

EXEC sp_ReservedTablesReport '2025-10-01', '2026-05-06';