USE HR_Analytics_db;
SELECT TOP 5 *  FROM HRDATA;

--Total Employees
SELECT SUM(employee_count) from hrdata;
SELECT SUM(employee_count) from hrdata where education='High School';

--Attrition

SELECT COUNT(*) AS Attrition
FROM hrdata
WHERE attrition = 'Yes';

--Attrition Rate
select 
round (((select count(*) from hrdata where attrition='yes') * 100.0 / 
sum(employee_count)), 2) as attrition_rate
from hrdata;	

--Active Employee
select sum(employee_count) - (select count(attrition) from hrdata  where attrition='Yes') as Active_Employee from hrdata;

--Average Age
select round(avg(age),0) as Avg_Age from hrdata;

--Attrition by Gender
select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by gender
order by count(attrition) desc;

--Department wise Attrition
select department, count(attrition) as Attrition_count, round((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as pct from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc;

--No of Employee by Age Group
	SELECT age,  sum(employee_count) AS employee_count FROM hrdata
	GROUP BY age
	order by age;

--Education Field wise Attrition
select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc;

--Attrition Rate by Gender for different Age Group
select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;

--Job Satisfaction Rating
SELECT *
FROM
(
    SELECT 
        job_role,
        job_satisfaction,
        employee_count
    FROM hrdata
) AS source_table
PIVOT
(
    SUM(employee_count)
    FOR job_satisfaction IN ([1], [2], [3], [4])
) AS pivot_table
ORDER BY job_role;




