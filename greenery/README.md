Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


## Project 1
#### How many users do we have?

SELECT COUNT(DISTINCT user_guid)
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_users;

- 130

#### On average, how many orders do we receive per hour?
SELECT ROUND(AVG(orders_count),2)
FROM(
    SELECT DATE_TRUNC('hour', created_at), COUNT(*) AS orders_count
    FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_orders
    GROUP BY 1
);

- 7.52

#### On average, how long does an order take from being placed to being delivered?
SELECT ROUND(AVG(DATEDIFF('hours', created_at, delivered_at)), 2) AS time_difference_minutes
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_orders;

- 93.4 hours

#### How many users have only made one purchase? Two purchases? Three+ purchases?
SELECT 
    frequency_count AS order_frequency, 
    COUNT(frequency_count) AS amount_users
FROM(
    SELECT 
        user_guid, 
        COUNT(user_guid) AS frequency_count
    FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_orders
    GROUP BY user_guid
    )
GROUP BY frequency_count
ORDER BY 1;

ORDER_FREQUENCY	AMOUNT_USERS
1	25
2	28
3	34
4	20
5	10
6	2
7	4
8	1

##### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

#### On average, how many unique sessions do we have per hour?
SELECT ROUND(AVG(sessions_count),2)
FROM(
    SELECT COUNT(DISTINCT session_guid) AS sessions_count
    FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_events
    GROUP BY DATE_TRUNC('hour', created_at)
);

- 16.33



