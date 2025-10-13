SELECT o.Id, o.ReservationId, oi.MenuItemId, mi.Name, oi.Quantity, oi.Notes, o.TotalPrice
FROM Orders o
JOIN OrderItems oi
ON o.Id = oi.OrderId
JOIN MenuItems mi
ON mi.Id = oi.MenuItemId
WHERE ReservationId = 2;