DELIMITER $$

CREATE FUNCTION years_diff_from_year(input_year INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE start_date DATE;
    DECLARE diff_years INT;

    -- Створюємо дату 1 січня відповідного року
    SET start_date = STR_TO_DATE(CONCAT(input_year, '-01-01'), '%Y-%m-%d');

    -- Різниця в роках між цією датою та поточною
    SET diff_years = TIMESTAMPDIFF(YEAR, start_date, CURDATE());

    RETURN diff_years;
END $$

DELIMITER ;

SELECT
    ps.country_id,
    ps.Year,
    STR_TO_DATE(CONCAT(ps.Year, '-01-01'), '%Y-%m-%d') AS Date_year_start,
    CURDATE() AS Date_current,
    years_diff_from_year(ps.Year) AS Date_years_diff
FROM pandemic_stats ps;
