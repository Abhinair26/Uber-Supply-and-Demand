
-- 1. Total number of requests
SELECT COUNT(*) AS total_requests FROM uber_requests;

-- 2. Number of completed trips
SELECT COUNT(*) AS completed_trips FROM uber_requests WHERE Status = 'Trip Completed';

-- 3. Number of cancelled trips
SELECT COUNT(*) AS cancelled_trips FROM uber_requests WHERE Status = 'Cancelled';

-- 4. Number of no cars available
SELECT COUNT(*) AS no_cars_available FROM uber_requests WHERE Status = 'No Cars Available';

-- 5. Requests by pickup point
SELECT Pickup_point, COUNT(*) AS request_count FROM uber_requests GROUP BY Pickup_point;

-- 6. Status distribution by pickup point
SELECT Pickup_point, Status, COUNT(*) AS status_count 
FROM uber_requests 
GROUP BY Pickup_point, Status;

-- 7. Peak request hours
SELECT strftime('%H', Request_timestamp) AS hour, COUNT(*) AS request_count 
FROM uber_requests 
GROUP BY hour 
ORDER BY request_count DESC;

-- 8. Supply-demand gap by pickup point
SELECT Pickup_point,
       SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) AS supply,
       COUNT(*) AS demand,
       COUNT(*) - SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) AS gap
FROM uber_requests
GROUP BY Pickup_point;
