-- Select bands with Glam Rock as their main style, calculate their lifespan and order by longevity
SELECT band_name, 
       CASE
           WHEN split IS NULL THEN 2022 - formed  -- If the band hasn't split, use 2022 as the end year
           ELSE split - formed  -- If the band has split, calculate using the split year
       END AS lifespan
FROM metal_bands
WHERE main_style = 'Glam rock'
ORDER BY lifespan DESC;
