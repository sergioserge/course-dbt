### Part 1: Create new models to answer the first two questions (answer questions in README file)

#### What is our overall conversion rate?
##### Def: conversion rate = # of unique sessions with a purchase event / total number of unique sessions
```
WITH purchase AS(
    SELECT 
        session_guid, 
        SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS purchase_done
    FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_events
    GROUP BY session_guid)
    
SELECT SUM(purchase_done)/count(purchase_done) AS conversion_rate FROM purchase;
```
--57.96%

#### What is our conversion rate by product?
##### Def: conversion rate by product = # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product
```
WITH sessions_products AS(
    SELECT 
        pe.session_guid,
        pe.product_guid,
        ps.purchase_done
    FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.base_purchase_sessions ps
    INNER JOIN DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_events pe
        ON ps.session_guid = pe.session_guid
    WHERE pe.product_guid IS NOT NULL),
    
sessions_products_count AS(
    SELECT 
        sp.product_guid,
        pp.name,
        COUNT(sp.product_guid) AS purchases_product,
        SUM(purchase_done) AS purchased_sessions,
        COUNT(purchase_done) AS total_sessions,
        purchased_sessions/ total_sessions AS conversion_rate
    FROM sessions_products sp
    INNER JOIN DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_products pp
        ON sp.product_guid = pp.product_guid
    GROUP BY sp.product_guid, pp.name)
    
SELECT * 
FROM sessions_products_count;
```
#### Part 2: We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project.
- I added a makro which creates a table with all tables in the database as well as their dimensions
```
SELECT *
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_source_tables_overview;
```

#### Part 3: We’re starting to think about granting permissions to our dbt models in our snowflake database so that other roles can have access to them.
- done, checked activities in snowflake

#### Part 4:  After learning about dbt packages, we want to try one out and apply some macros or tests.
- added:
```
- name: stg_postgres_orders
    description: orders
    tests: 
    - dbt_utils.fewer_rows_than:
        compare_model: ref('stg_postgres_order_items')
```

#### Part 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!
- done

Pothos
Bamboo
Philodendron
Monstera
String of pearls
ZZ Plant