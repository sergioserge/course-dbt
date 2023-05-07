### Part 1. dbt Snapshots
#### 1.2 Which products had their inventory change from week 3 to week 4? 
Monstera
Philodendron
Bamboo
ZZ Plant
String of pearls
Pothos

#### 1.3 which products had the most fluctuations in inventory?
```
SELECT 
    name,
    MIN(inventory) AS min_inventory, 
    MAX(inventory) AS max_inventory,
    max_inventory - min_inventory AS inventory_difference
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.INVENTORY_SNAPSHOT
GROUP BY name
ORDER BY inventory_difference DESC;
```

### Part 2. Modeling challenge
- Honestly I am not quite sure what kind of model is exactly expected here. I just did what I was thinking about. Next step will be to review other peoples work.
Afterwards I might need to refine my own work.
```
SELECT *
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.fact_product_funnel;
SELECT *
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.fact_product_funnel_agg;
```
- I would use the average values from conversion rates of page_views and add_to_cart for all products combined 
to select the underperforming conversion rates for both stages for every individual product. 
So to ask why certain products have a higher drop out rate than the average

### 3A. dbt next steps for you 
Reflecting on your learning in this class...

#### if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?
- dbt supports a structure approach to organise our organisations datastreams
- dbt supports documentation of datastreams
- DAG helps integrate new data flows and new business user requirements into the existing data infrastructure

#### if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
- don't really know our dbt infrastructure yet

#### if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?
- changed my overall thinking about structuring different steps of transformation of the overall data stream
