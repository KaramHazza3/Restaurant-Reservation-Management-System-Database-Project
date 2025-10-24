CREATE PROCEDURE sp_FutureReservationTables
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TableId, AssignedSeats, CreatedAt
	INTO #TempTable
	FROM ReservationTable
	WHERE CreatedAt > GETDATE();

	SELECT DISTINCT r.Id AS RestaurantId, r.Name AS RestaurantName, t.TableNumber, t.Capacity, temp.AssignedSeats
	FROM #TempTable temp
	JOIN Tables t
	ON temp.TableId = t.Id
	JOIN Restaurants r
	ON r.Id = t.RestaurantId

END;

EXEC sp_FutureReservationTables;