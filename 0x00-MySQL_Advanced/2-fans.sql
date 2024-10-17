-- calling from other thing
-- Select the origin and sum of fans, grouped by origin, ordered by total fans
SELECT origin, SUM(nb_fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
