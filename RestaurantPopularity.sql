SELECT r.Id,
r.Name,
COUNT(res.RestaurantId) AS ReservationCount,
DENSE_RANK() OVER (ORDER BY COUNT(res.RestaurantId) DESC) As RestaurantRank
FROM Restaurants r
JOIN Reservations res
ON r.Id = res.RestaurantId
GROUP BY r.Id, r.Name
ORDER BY RestaurantRank DESC;