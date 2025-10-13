CREATE VIEW EmployeeDetails AS
SELECT e.Id, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, e.Position, r.Name, r.Address
FROM Employees e
JOIN Restaurants r
ON r.Id = e.RestaurantId;

SELECT * FROM EmployeeDetails;