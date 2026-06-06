--whole data
select *
from Project1..events

--cte creation
with events as 
(
select *
from Project1..events
)

--total revenue all item
with total_revenue as 
(
select sum(total_revenue) as total_income
from events
)

select *
from total_revenue

--revenue share and profit margin
with helper1 as
(
select item_category, total_revenue, total_profit
from events
),
helper2 as
(
select sum(total_revenue) as total_income
from events
)

select 
    q.item_category, 
    sum(q.total_revenue) / r.total_income * 100 as revenue_share, 
    sum(q.total_profit) / sum(q.total_revenue)*100 as profit_margin,
    sum(sum(q.total_revenue) / r.total_income * 100) over (order by sum(q.total_revenue) / r.total_income * 100 desc) as rolling_revenue_share,
    CASE
        WHEN sum(sum(q.total_revenue) / r.total_income * 100) over (order by sum(q.total_revenue) / r.total_income * 100 desc) <= 80 THEN 'A'
        WHEN sum(sum(q.total_revenue) / r.total_income * 100) over (order by sum(q.total_revenue) / r.total_income * 100 desc) <= 95 THEN 'B'
        ELSE 'C'
    END AS abc_analysis
from helper1 q
cross join helper2 r
where q.item_category is not null
group by q.item_category, r.total_income
order by revenue_share desc

--ABC analysis by revenue
with helper as
(select item_category, 
	sum(total_revenue)/1704556513.91*100 as revenue_share, 
	sum(total_profit)/sum(total_revenue)*100 as profit_margin
from events
where item_category is not null
group by item_category)

select *, 
	sum(revenue_share) over (order by revenue_share desc) as rolling_revenue_share,
    CASE
        WHEN sum(revenue_share) over (order by revenue_share desc) <= 80 THEN 'A'
        WHEN sum(revenue_share) over (order by revenue_share desc) <= 95 THEN 'B'
        ELSE 'C'
    END AS abc_analysis
from helper
order by revenue_share desc

--geographic analysis 
WITH region_orders AS
(
    SELECT 
        region,
        COUNT(DISTINCT CAST(order_id AS INT)) AS orders_per_region
    FROM events
    GROUP BY region
),
total_orders AS
(
    SELECT 
        COUNT(DISTINCT CAST(order_id AS INT)) AS total_orders
    FROM events
)

SELECT 
    r.region,
    r.orders_per_region * 100 / t.total_orders AS order_share
FROM region_orders r
CROSS JOIN total_orders t
WHERE r.region is not null
ORDER BY r.region;

--top markets (revenue, units sold, profit) by country
WITH country_revenue AS
(
    SELECT 
        region,
        country,
        sum(total_revenue) AS revenue_by_country,
        sum(units_sold) AS total_units_sold,
        sum(total_profit) AS total_profit,
        sum(total_profit)/sum(total_revenue)*100 AS profit_margin
    FROM events
    GROUP BY region, country
),
total_revenue AS
(
    SELECT 
        sum(total_revenue) AS total_overall_revenue
    FROM events
)

SELECT 
    r.country,
    r.revenue_by_country * 100 / t.total_overall_revenue AS revenue_share,
    r.total_units_sold,
    r.total_profit,
    r.profit_margin
FROM country_revenue r
CROSS JOIN total_revenue t
WHERE r.country is not null and r.region = 'Europe'
ORDER BY revenue_share desc

--top markets by country and region
SELECT 
    region,
    country,
    sum(total_revenue) AS revenue_by_country,
    sum(units_sold) AS total_units_sold,
    sum(total_profit) AS total_profit,
    sum(total_profit)/sum(total_revenue)*100 AS profit_margin
FROM events
WHERE Region is not null and Region != 'UNKNOWN'
GROUP BY region, country
ORDER BY total_units_sold desc

--sales channel analysis
--order distribution, order size, product mix, geographic reach, profit margin
with total_sold as
(
select 
    sales_channel, 
    sum(units_sold) as total_units_sold,
    sum(total_revenue) as total_revenue,
    avg(units_sold) as avg_sold,
    count(distinct(product_id)) as count_sku,
    sum(total_profit) as overall_profit
from events
where sales_channel is not null
group by sales_channel
),
overall_sold as
(
select 
    sum(units_sold) as total_units_sold,
    sum(total_revenue) as overall_revenue
from events
)

select 
    r.sales_channel,
    r.total_units_sold / q.total_units_sold * 100 as percent_units_sold,
    r.total_revenue / q.overall_revenue * 100 as percent_revenue,
    r.avg_sold as avg_order_size,
    r.total_revenue / r.total_units_sold as product_mix,
    r.overall_profit / r.total_revenue * 100 as profit_margin
from total_sold r
cross join overall_sold q

--avg order size
select 
    sales_channel,
    sum(units_sold)/count(distinct(cast(product_id as int))) as order_size
from events
where sales_channel is not null
group by sales_channel
order by order_size desc

--geographic reach
SELECT
    item_category,
    COUNT(DISTINCT CASE 
        WHEN sales_channel = 'Online' THEN country 
    END) AS online_reach,
    COUNT(DISTINCT CASE 
        WHEN sales_channel = 'Offline' THEN country 
    END) AS offline_reach
FROM events
WHERE item_category is not null
GROUP BY item_category