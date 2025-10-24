CREATE PROCEDURE sp_AddNewOrder
	@ReservationId INT,
	@EmployeeId INT,
	@OrderDate DATETIME,
	@TotalAmount DECIMAL(10,2),
	@Discount DECIMAL(10,2),
	@Tax DECIMAL(10,2)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		IF NOT EXISTS (SELECT 1 FROM Reservations WHERE Id = @ReservationId)
		BEGIN
			RAISERROR('Reservation not found', 16, 1)
			ROLLBACK TRANSACTION;
			RETURN;
		END;

		IF NOT EXISTS (SELECT 1 FROM Employees WHERE Id = @EmployeeId)
		BEGIN
			RAISERROR('Employee not found', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN;
		END;
		
		DECLARE @NewOrderId INT;

		INSERT INTO Orders (ReservationId, EmployeeId, TotalPrice, Discount, Tax, CreatedAt)
		VALUES (@ReservationId, @EmployeeId, @TotalAmount, @Discount, @Tax, @OrderDate);
		
		SET @NewOrderId = SCOPE_IDENTITY();
		SELECT @NewOrderId AS NewOrderId;

		COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		DECLARE @ErrorMsg NVARCHAR(4000);
		SET @ErrorMsg = ERROR_MESSAGE();
		RAISERROR(@ErrorMsg, 16, 1);

	END CATCH
END;

EXEC sp_AddNewOrder
    @ReservationId = 87211,
    @EmployeeId = 1,
    @OrderDate = '2025-10-03',
    @TotalAmount = 504.0,
    @Discount = 0,
    @Tax = 0;

EXEC sp_AddNewOrder
    @ReservationId = 1,
    @EmployeeId = 8722131,
    @OrderDate = '2025-10-03',
    @TotalAmount = 504.0,
    @Discount = 0,
    @Tax = 0;

EXEC sp_AddNewOrder
    @ReservationId = 1,
    @EmployeeId = 1,
    @OrderDate = '2025-10-03',
    @TotalAmount = 504.0,
    @Discount = 0,
    @Tax = 0;