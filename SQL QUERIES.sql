--  Task 1: Customer Segmentation Based on Balance
select case
			when balance <500 then 'Low'
            when balance between 500 and 2500 then 'Medium'
            when balance>2500 then 'High'
            else '0'
		end as 'segmentation',count(*) as no_of_customers
from bank_customers
group by segmentation;

-- Task 2: Loan vs. Non-Loan Customers
select 	loan,
		round(avg(balance),2) as Avg_balance,
        count(*) as no_of_cus,
		ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage_of_customers
from bank_customers
group by loan;


-- Task 3: Campaign Performance by Month
select 	month,
        count(*) as successful_response,
        rank() over(order by count(*) desc) as rnk
from bank_customers
where target_response = 'yes'
group by month;


-- Task 4: Most Engaged Jobs
select	job,
		round(avg(duration),2) as avg_duration
from bank_customers
where target_response = 'yes'
group by job
order by avg_duration desc
limit 5;


-- Task 5: High-Risk Customer Pattern
select count(*) no_of_customers, 
		round( avg(age),1 ) as avg_age
from bank_customers
where housing='yes' and loan='yes' and balance <1000;