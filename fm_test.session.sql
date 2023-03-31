/* BCNF (Нормальная Форма Бойса-Кодда) */
CREATE TABLE "restaurants"(id serial PRIMARY KEY);
CREATE TABLE "deliveries"(id serial PRIMARY KEY);
CREATE TABLE "pizzas"(id serial PRIMARY KEY);

CREATE TABLE "restaurants_to_pizzas"(
    "restaurant_id" INT REFERENCES "restaurants".id,
    "pizzas_id" INT REFERENCES "pizzas".id,
    PRIMARY KEY ("restaurant_id", "pizzas_id")
);

CREATE TABLE "restaurants_to_deliveries"(
    "restaurant_id" INT REFERENCES "restaurants".id,
    "deliveries_id" INT REFERENCES "deliveries".id,
    pizza
    PRIMARY KEY ("restaurant_id", "deliveries_id")
);

INSERT INTO "restaurants_to_deliveries"
VALUES
(1,1),
(2,1);

INSERT INTO "restaurants_to_pizzas"
VALUES
(1,101),
(2,114);


SELECT *
FROM "phones"
WHERE description IS NULL

INSERT INTO "users" (
    "firstName",
    "lastName",
    "email",
    "isMale",
    "birthday",
    "height"
)
VALUES (
    'Ivan',
    'Yarem',
    'yarem@gmail.com',
    true,
    '1998-10-31',
    1.72
),
VALUES (
    'Ann',
    'Lezed',
    'lezed@gmail.com',
    false,
    '2001-08-28',
    1.56
);

/* First option of CASE */
SELECT(
    CASE
        WHEN 1='1' THEN 1
        WHEN false=false THEN 2
        ELSE 3
    END
) AS "case";


SELECT *, (
    CASE
        WHEN "isMale" THEN 'Male'
        ELSE 'Female'
    END
) AS "gender", "isMale"
FROM "users";

/* Second option of CASE */
SELECT (
    CASE extract(month FROM "birthday")
        WHEN 1 THEN 'Winter'
        WHEN 2 THEN 'Winter'
        WHEN 3 THEN 'Spring'
        WHEN 4 THEN 'Spring'
        WHEN 5 THEN 'Spring'
        WHEN 6 THEN 'Summer'
        WHEN 7 THEN 'Summer'
        WHEN 8 THEN 'Summer'
        WHEN 9 THEN 'Autumn'
        WHEN 10 THEN 'Autumn'
        WHEN 11 THEN 'Autumn'
        WHEN 12 THEN 'Winter'
    END
) AS "season", "birthday"
FROM "users";


/* Добавить колонку, в которой определить возраст (до 25 - young age; с 25 - average age) */
SELECT (
    CASE extract(year FROM age("birthday"))
        <25 THEN 'young'
        ELSE 'average'
    END
) AS "age", "birthday"
FROM "users";


/* Добавить колонку, где если бренд телефона называется Sony, то вмест этого пишем SonyEricson, в остальных случаях пишем other */
SELECT (
    CASE 
        WHEN "brand" ILIKE 'sony' THEN 'SonyEricson'
        ELSE 'other'
    END
) AS "manufacturer", "brand"
FROM "phones";
-- or
SELECT (
    CASE "brand"
        WHEN 'Sony' THEN 'SonyEricson'
        WHEN 'sony' THEN 'SonyEricson'
        ELSE 'other'
    END
) AS "manufacturer", "brand"
FROM "phones";

/* Добавить колонку, в которой определить доступность телефона (
    <6000 - low
    6000...15000 - average
    >15000 - high
) */
SELECT (
    CASE
        WHEN "price" <6000 THEN 'low'
        WHEN "price" >15000 THEN 'high'
        ELSE 'average'
    END
) AS "availibility", "price"
FROM "phones";

/* Добавить колонку, в которой определить телефоны с ценой выше средней и ниже средней */
SELECT (
    CASE
        WHEN "price" = (SELECT avg("price") FROM "phones") THEN 'above'
        ELSE 'below'
    END
) AS "varietyOfThePrice", "price"
FROM "phones";


-- COALESCE - возвращает первый попавшийся аргумент, отличный от NULL
SELECT COALESCE(NULL, 1, NULL);

SELECT model, COALESCE(description, 'Not info')
FROM "phones";

-- NULLIF - возвращает NULL,  если значения одинаковые, а если не одинаковые - то первое
SELECT NULLIF(1,1); -- NULL
SELECT NULLIF(4,1); -- 4
SELECT NULLIF(NULL,NULL); -- NULL
SELECT NULLIF(NULL,1); -- NULL
SELECT NULLIF(1,NULL); -- 1
SELECT NULLIF(1,'1'); -- NULL
SELECT NULLIF('1',1); -- NULL


/* Получить пользователей, которые не делали заказов */
SELECT *
FROM "users" AS u
WHERE u.id NOT IN (SELECT "userId" FROM "orders");
-- EXISTS
SELECT *
FROM "users" AS u
WHERE NOT EXISTS (
    SELECT o."userId" 
    FROM "orders" AS o
    WHERE o."userId"=u.id
);
-- ALL
SELECT *
FROM "users" AS u
WHERE u.id != ALL(SELECT "userId" FROM "orders");
-- SOME
SELECT *
FROM "users" AS u
WHERE u.id = SOME(SELECT "userId" FROM "orders");


CREATE OR REPLACE VIEW "email_season_birthDay" AS (
    SELECT (
    CASE extract(month FROM "birthday")
        WHEN 1 THEN 'Winter'
        WHEN 2 THEN 'Winter'
        WHEN 3 THEN 'Spring'
        WHEN 4 THEN 'Spring'
        WHEN 5 THEN 'Spring'
        WHEN 6 THEN 'Summer'
        WHEN 7 THEN 'Summer'
        WHEN 8 THEN 'Summer'
        WHEN 9 THEN 'Autumn'
        WHEN 10 THEN 'Autumn'
        WHEN 11 THEN 'Autumn'
        WHEN 12 THEN 'Winter'
    END
) AS "season", "email", "firstName"
FROM "users";
);

SELECT count("season"), "season" FROM "email_season_birthDay"
GROUP BY "season";