CREATE FUNCTION fn_CalculateEmployeeSalary(@EmployeeId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN

	DECLARE @EmployeeSalary DECIMAL(10,2)
	DECLARE @EmployeePosition VARCHAR(15)
	SELECT
	@EmployeeSalary = ISNULL(COUNT(o.Id), 0),
	@EmployeePosition = e.Position
	FROM Employees e
	LEFT JOIN Orders o 
	ON e.Id = o.EmployeeId
	WHERE e.Id = @EmployeeId
	GROUP BY e.Id, e.Position

	IF @EmployeePosition = 'VIPOrdersWaiter'
		SET @EmployeeSalary = @EmployeeSalary * 5;
	ELSE IF @EmployeePosition = 'StandardWaiter'
		SET @EmployeeSalary = @EmployeeSalary * 4;
	ELSE IF @EmployeePosition = 'AssistantWaiter'
		SET @EmployeeSalary = @EmployeeSalary * 3;

	RETURN ISNULL(@EmployeeSalary, 0);
END;

SELECT dbo.fn_CalculateEmployeeSalary(1);