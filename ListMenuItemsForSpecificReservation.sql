SELECT mi.Id, mi.Name
FROM OrderItems oi
JOIN Orders o
ON oi.OrderId = o.Id
JOIN MenuItems mi
ON mi.Id = oi.MenuItemId
WHERE o.ReservationId = 2;