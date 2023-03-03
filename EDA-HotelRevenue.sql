-- Looking through the datasets

select TOP 10 * from Project..['2018$'];
select TOP 10 * from Project..['2019$'];
select TOP 10 * from Project..['2020$'];

-- 1) Combining 3 datasets. Resultant table has 100756 observations
-- 2) EDA1 --> Check if revenue is increasing by year
-- 3) revenue = derived column using stays_in_week_nights, stays_in_weekend_nights and ADR
-- 4) Group Data by arrival_date_year

with RowCombCTE as(
	select * from Project..['2018$']
	union
	select * from Project..['2019$']
	union
	select * from Project..['2020$'])
select arrival_date_year, 
SUM((stays_in_week_nights + stays_in_weekend_nights)*adr) as revenue 
from RowCombCTE
group by arrival_date_year;

-- Evidently the overall revenue is increaing as year increases.

with RowCombCTE as(
	select * from Project..['2018$']
	union
	select * from Project..['2019$']
	union
	select * from Project..['2020$'])
select arrival_date_year, hotel,
SUM((stays_in_week_nights + stays_in_weekend_nights)*adr) as revenue 
from RowCombCTE
group by arrival_date_year, hotel;

-- Data output says 2018 to 2019 shows a significant increase in revenue, however 2019 to 2020 revenue decreased dramatically and is still
-- yielding an income greater than in 2018

-- Joining datasets

with RowCombCTE as(
	select * from Project..['2018$']
	union
	select * from Project..['2019$']
	union
	select * from Project..['2020$'])
select * from RowCombCTE r
	left join Project..market_segment$ ms
		on r.market_segment = ms.market_segment
	left join Project..meal_cost$ mc
		on r.meal = mc.meal;


