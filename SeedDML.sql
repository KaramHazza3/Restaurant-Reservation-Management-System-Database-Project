-- Seed 50 restaurants

SET NOCOUNT ON;

DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    INSERT INTO Restaurants (Name, Address, PhoneNumber, OpeningHours, CreatedBy, UpdatedBy)
    VALUES (
        CONCAT('Restaurant ', @i),
        CONCAT('Street ', @i, ', City ', @i),
        CONCAT('050', FORMAT(@i,'00000')),
        '10:00-22:00',
        1, 1
    );
    SET @i = @i + 1;
END


-- Seed 400 customers
DECLARE @j INT = 1;
WHILE @j <= 400
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, CreatedBy, UpdatedBy)
    VALUES (
        CONCAT('CustomerFirst', @j),
        CONCAT('CustomerLast', @j),
        CONCAT('customer', @j, '@example.com'),
        CONCAT('059', FORMAT(@j,'00000')),
        1,1
    );
    SET @j = @j + 1;
END


-- Seed 100 employees with simplified positions
DECLARE @k INT = 1;
DECLARE @positions TABLE (PositionName VARCHAR(50));
INSERT INTO @positions VALUES
('Manager'), ('Waiter'), ('AssistantWaiter'),
('Chef'), ('Host'), ('Cashier');

WHILE @k <= 100
BEGIN
    INSERT INTO Employees (RestaurantId, FirstName, LastName, Position, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*49 AS INT), -- Random restaurant 1-50
        CONCAT('EmpFirst', @k),
        CONCAT('EmpLast', @k),
        (SELECT TOP 1 PositionName FROM @positions ORDER BY NEWID()), -- Random position
        1, 1
    );
    SET @k = @k + 1;
END

-- Seed 100 tables
DECLARE @t INT = 1;
WHILE @t <= 100
BEGIN
    INSERT INTO Tables (RestaurantId, TableNumber, Capacity, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*49 AS INT),
        CAST(1 + RAND()*20 AS INT),  -- Table numbers 1-20
        CAST(2 + RAND()*6 AS INT),   -- Capacity 2-8
        1,1
    );
    SET @t = @t + 1;
END


-- Seed 1000 menu items
DECLARE @m INT = 1;
WHILE @m <= 1000
BEGIN
    INSERT INTO MenuItems (RestaurantId, Name, Description, Price, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*49 AS INT),
        CONCAT('Dish ', @m),
        CONCAT('Description of dish ', @m),
        CAST(5 + RAND()*45 AS DECIMAL(10,2)), -- Price 5-50
        1,1
    );
    SET @m = @m + 1;
END

-- Seed 500 reservations
DECLARE @r INT = 1;
WHILE @r <= 500
BEGIN
    INSERT INTO Reservations (RestaurantId, CustomerId, PartySize, Status, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*49 AS INT),
        CAST(1 + RAND()*399 AS INT),
        CAST(1 + RAND()*8 AS INT), -- Party size 1-8
        CASE WHEN RAND() < 0.8 THEN 'Confirmed' ELSE 'Cancelled' END,
        1,1
    );
    SET @r = @r + 1;
END

-- Assign tables to reservations (simplified)
INSERT INTO ReservationTable (TableId, ReservationId, AssignedSeats, CreatedBy, UpdatedBy)
SELECT TOP 500
    CAST(1 + RAND()*99 AS INT), -- random table
    r.Id,
    r.PartySize,
    1,1
FROM Reservations r

-- Seed 500 orders
DECLARE @o INT = 1;
WHILE @o <= 500
BEGIN
    INSERT INTO Orders (ReservationId, EmployeeId, TotalPrice, Discount, Tax, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*499 AS INT), -- Reservation
        CAST(1 + RAND()*99 AS INT),  -- Employee
        CAST(50 + RAND()*150 AS DECIMAL(10,2)), -- total price
        CAST(RAND()*20 AS DECIMAL(10,2)),       -- discount
        CAST(RAND()*10 AS DECIMAL(10,2)),       -- tax
        1,1
    );
    SET @o = @o + 1;
END

-- Seed 1500 order items
DECLARE @oi INT = 1;
WHILE @oi <= 1500
BEGIN
    INSERT INTO OrderItems (OrderId, MenuItemId, Quantity, Notes, CreatedBy, UpdatedBy)
    VALUES (
        CAST(1 + RAND()*499 AS INT),  -- OrderId
        CAST(1 + RAND()*999 AS INT),  -- MenuItemId
        CAST(1 + RAND()*5 AS INT),    -- Quantity
        'No spicy',                   -- Note
        1,1
    );
    SET @oi = @oi + 1;
END
