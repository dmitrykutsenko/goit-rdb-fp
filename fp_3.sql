USE pandemic;

SELECT 
    c.Entity,
    c.Code,
    AVG(ps.Number_rabies) AS avg_rabies,
    MIN(ps.Number_rabies) AS min_rabies,
    MAX(ps.Number_rabies) AS max_rabies,
    SUM(ps.Number_rabies) AS sum_rabies
FROM pandemic_stats ps
JOIN countries c 
    ON ps.country_id = c.country_id
WHERE ps.Number_rabies IS NOT NULL
GROUP BY c.Entity, c.Code
ORDER BY avg_rabies DESC
LIMIT 10;
