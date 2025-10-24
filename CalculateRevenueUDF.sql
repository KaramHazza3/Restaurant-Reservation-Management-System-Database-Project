CREATE FUNCTION fn_CalculateRevenue(@RestaurantId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @Revenue DECIMAL(10,2);

	SELECT @Revenue = SUM(oi.Quantity * mi.Price)
	FROM OrderItems oi
	JOIN MenuItems mi
	ON oi.MenuItemId = mi.Id
	WHERE mi.RestaurantId = @RestaurantId;

	RETURN ISNULL(@Revenue, 0);
END;

SELECT dbo.fn_CalculateRevenue(1);