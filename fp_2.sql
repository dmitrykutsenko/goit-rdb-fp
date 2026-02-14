-- #0 
-- Перевіримо кількість завантажених записів із файлу
SELECT COUNT(*) 
FROM infectious_cases;

-- #1
-- Створюємо таблицю довідника країн
-- Усі унікальні пари Entity + Code мають жити в окремій таблиці
CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    Entity VARCHAR(100) NOT NULL,
    Code VARCHAR(10)
);

-- #2
-- Створюємо основну таблицю фактів
-- Тут зберігатимуться всі числові показники, а країна буде посилатися на countries.country_id
CREATE TABLE pandemic_stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    Year INT,
    Number_yaws INT,
    polio_cases INT,
    cases_guinea_worm INT,
    Number_rabies DECIMAL(20,6),
    Number_malaria DECIMAL(20,6),
    Number_hiv DECIMAL(20,6),
    Number_tuberculosis DECIMAL(20,6),
    Number_smallpox INT,
    Number_cholera_cases INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- Трохи модифікуємо початкову таблицю
ALTER TABLE infectious_cases
 MODIFY Number_yaws INT,
 MODIFY polio_cases INT,
 MODIFY cases_guinea_worm INT,
 MODIFY Number_rabies DECIMAL(20,6),
 MODIFY Number_malaria DECIMAL(20,6),
 MODIFY Number_hiv DECIMAL(20,6),
 MODIFY Number_tuberculosis DECIMAL(15,6),
 MODIFY Number_smallpox INT,
 MODIFY Number_cholera_cases INT;
 
-- #3
-- Заповнюємо таблицю countries
-- Витягнемо унікальні країни з імпортованої таблиці 
INSERT INTO countries (Entity, Code)
SELECT DISTINCT Entity, Code
FROM infectious_cases
WHERE Entity IS NOT NULL;

-- #4
-- Переносимо дані у нормалізовану таблицю
-- Тут ми замінюємо Entity і Code на country_id
INSERT INTO pandemic_stats (
    country_id, Year, Number_yaws, polio_cases, cases_guinea_worm,
    Number_rabies, Number_malaria, Number_hiv, Number_tuberculosis,
    Number_smallpox, Number_cholera_cases
)
SELECT 
    c.country_id,
    inf.Year,
    inf.Number_yaws,
    inf.polio_cases,
    inf.cases_guinea_worm,
    inf.Number_rabies,
    inf.Number_malaria,
    inf.Number_hiv,
    inf.Number_tuberculosis,
    inf.Number_smallpox,
    inf.Number_cholera_cases
FROM infectious_cases inf
JOIN countries c
    ON inf.Entity = c.Entity AND (inf.Code = c.Code OR c.Code IS NULL);

-- CSV → infectious_cases → pandemic_stats (3NF) + countries