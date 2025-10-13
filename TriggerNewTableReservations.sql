CREATE TABLE LogAudit
(
	RestaurantId INT,
	TableNumber INT,
	ReservationDate DATETIME,
	ChangeDate DATETIME
);

CREATE TRIGGER trg_LogNewReservationTables
ON ReservationTable
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO LogAudit (RestaurantId, TableNumber, ReservationDate, ChangeDate)
	SELECT t.RestaurantId, t.TableNumber, i.CreatedAt, GETDATE()
	FROM INSERTED i
	JOIN Tables t
	ON i.TableId = t.Id
END;


INSERT INTO ReservationTable (TableId, ReservationId, AssignedSeats, CreatedAt, UpdatedAt)
VALUES (4, 1, 2, GETDATE(), GETDATE());

SELECT * FROM LogAudit;