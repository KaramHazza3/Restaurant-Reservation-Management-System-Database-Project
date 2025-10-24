WITH PopularMenuItems AS (
    SELECT
        mi.RestaurantId,
        mi.Name,
        SUM(oi.Quantity) AS OrderedCount,
        DENSE_RANK() OVER (
            PARTITION BY mi.RestaurantId
            ORDER BY SUM(oi.Quantity) DESC
        ) AS MostPopular
    FROM MenuItems mi
    JOIN OrderItems oi ON mi.Id = oi.MenuItemId
    JOIN Orders o ON o.Id = oi.OrderId
    WHERE MONTH(o.CreatedAt) = 10
    GROUP BY mi.RestaurantId, mi.Name
)
SELECT RestaurantId, Name, OrderedCount
FROM PopularMenuItems
WHERE MostPopular = 1;