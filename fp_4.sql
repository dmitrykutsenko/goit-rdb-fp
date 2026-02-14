USE pandemic;

SELECT
    ps.country_id,
    ps.Year,
    
    -- 1) Дата першого січня відповідного року
    STR_TO_DATE(CONCAT(ps.Year, '-01-01'), '%Y-%m-%d') AS Date_year_start,
    
    -- 2) Поточна дата
    CURDATE() AS Date_current,
    
    -- 3) Різниця в роках
    TIMESTAMPDIFF(
        YEAR,
        STR_TO_DATE(CONCAT(ps.Year, '-01-01'), '%Y-%m-%d'),
        CURDATE()
    ) AS Date_years_diff

FROM pandemic_stats ps;
