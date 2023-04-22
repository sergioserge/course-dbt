## Week 2 Project



#### What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased

- see also fact_users.sql model in marts(code adjusted to be dim_fact stage ready)
```
with purchases AS(
SELECT  
    user_guid, 
    COUNT(*) AS purchase_frequency
FROM DEV_DB.DBT_SERGEJLUSTNEUEFISCHEDE.stg_postgres_orders
GROUP BY user_guid
HAVING purchase_frequency > 1
ORDER BY 2)

SELECT COUNT(*)
FROM purchases;
```
--> 99



#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
##### Purchase again indicators:
- the higher the order frequency
- the smaller gaps between orders


##### Not purchase again indicators:
- ordered often in the past but stopped in recent future
- increasing gaps between orders
- reviews
- complains


##### Explain the product mart models you added. Why did you organize the models in the way you did?
- I tried to create int models which could be reused by other departments
- In fact models tried to prepare the data it could be used in a BI tool, so kinda a balance between aggregated and joined but leave space for further aggregation in the BI tool itself

##### Tests
- I added for all ids which should be used as primary keys unique and not null
- also a few relationships test where I think that the releationship should also exists, like address_guid in both users and addresses table. Makes no sense to have an address for a non existing user

##### Snapshot
- Here I didn't see any change. I expected to find some values in 'DBT_VALID_TO' column for the rows which aren't the last ones. But I am not sure whether I got any new entries at all
- I didn't find any bad data

##### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
- Setup some knind of trigger event to run dbt models and test regularly. I would setup alert notification in case somethng went wrong(email, slack)
