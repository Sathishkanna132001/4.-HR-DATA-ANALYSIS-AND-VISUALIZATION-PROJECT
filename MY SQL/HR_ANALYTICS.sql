# USE THE DATABASE
use hr_dataset;

# DECRIBE THE DATASET
describe hr_1;
describe hr_2;

# RENAME THE COLUMNS FOR HR_1
ALTER TABLE hr_1 CHANGE BusinessTravel Business_Travel text;
ALTER TABLE hr_1 CHANGE Dailyrate Daily_Rate INT;
ALTER TABLE hr_1 CHANGE DistanceFromHome Distance_From_Home_To_Company DOUBLE;
ALTER TABLE hr_1 CHANGE EducationField Education_Field TEXT;
ALTER TABLE hr_1 CHANGE EmployeeNumber Emp_Number INT;
ALTER TABLE hr_1 CHANGE EnvironmentSatisfaction Env_Satisfaction INT;
ALTER TABLE hr_1 CHANGE HourlyRate Hourly_Rate INT;
ALTER TABLE hr_1 CHANGE JobInvolvement Job_Involvement int;
ALTER TABLE hr_1 CHANGE JobLevel Job_Level int;
ALTER TABLE hr_1 CHANGE JobSatisfaction Job_Satisfaction int;
ALTER TABLE hr_1 CHANGE MaritalStatus Marital_Status TEXT;
ALTER TABLE hr_1 CHANGE JobRole Job_Role TEXT;

# RENAME THE COLUMNS FOR HR_2
ALTER TABLE hr_2 CHANGE MonthlyIncome Monthly_Income INT;
ALTER TABLE hr_2 CHANGE MonthlyRate Monthly_Rating INT;
ALTER TABLE hr_2 CHANGE NumCompaniesWorked No_Companies_Worked INT;
ALTER TABLE hr_2 CHANGE Over18 Over_18 TEXT;
ALTER TABLE hr_2 CHANGE PercentSalaryHike Percent_Salary_Hike INT;
ALTER TABLE hr_2 CHANGE PerformanceRating Performance_Rating INT;
ALTER TABLE hr_2 CHANGE RelationshipSatisfaction Relationship_Satisfaction INT;
ALTER TABLE hr_2 CHANGE StandardHours Standard_Hours INT;
ALTER TABLE hr_2 CHANGE TotalWorkingYears Total_Working_Years INT;
ALTER TABLE hr_2 CHANGE TrainingTimesLastYear Training_Times_Last_Year INT;
ALTER TABLE hr_2 CHANGE WorkLifeBalance Work_Life_Balance INT;
ALTER TABLE hr_2 CHANGE YearsAtCompany Years_At_Company INT;
ALTER TABLE hr_2 CHANGE YearsInCurrentRole Years_InCurrent_Role INT;
ALTER TABLE hr_2 CHANGE YearsSinceLastPromotion Years_Since_Last_Promotion INT;
ALTER TABLE hr_2 CHANGE YearsWithCurrManager Years_With_Current_Manager INT;

create view hr_analysis as
select hr_1.Emp_Number, hr_1.Gender, hr_1.Age, hr_1.Education_Field, hr_1.Department, hr_1.Job_Role, hr_1.Job_Level,
hr_1.Job_Satisfaction,hr_2.Monthly_Income, hr_2.Percent_Salary_Hike,hr_1.Marital_Status,
hr_2.Performance_Rating,hr_2.Monthly_Rating,hr_1.Hourly_Rate, hr_1.Daily_Rate, hr_2.OverTime, hr_1.Business_Travel,
hr_1.Distance_From_Home_To_Company, hr_2.No_Companies_Worked, hr_2.Total_Working_Years, hr_2.Years_At_Company,
hr_2.Years_InCurrent_Role, hr_2.Years_Since_Last_Promotion, hr_2.Years_With_Current_Manager, hr_2.Over_18, hr_1.Attrition,
hr_1.Job_Involvement, hr_1.Env_Satisfaction, hr_2.Relationship_Satisfaction, hr_2.Work_Life_Balance, 
hr_2.Training_Times_Last_Year, hr_2.Standard_Hours
from hr_1
inner join hr_2 on hr_1.Emp_Number=hr_2.Emp_Number;

Select * from hr_1;
select * from hr_2;
select * from hr_analysis;

# 1.count number of attrition "Yes" and "No" in each department?

SELECT Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Yes,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Attrition_No
FROM hr_analysis
GROUP BY Department;

# 2.Average Monthly Income and Hike % By Department?

SELECT Department,
    AVG(Monthly_Income) AS Average_Monthly_Income,
    AVG(Percent_Salary_Hike) AS Average_Percent_Salary_Hike
FROM hr_analysis
GROUP BY Department;

# 3.What is the average monthly income of Educational Field ?

SELECT Education_Field,
    AVG(Monthly_Income) AS Average_Monthly_Income
FROM hr_analysis
GROUP BY Education_Field;

# 4.count marital Status Both Male and Female	

SELECT Marital_Status,Gender,COUNT(*) AS Count
FROM hr_analysis
GROUP BY Marital_Status,Gender
order by Marital_Status asc;

# 5.Which department has monthly high ratings ?

SELECT Department, max(Monthly_Rating) AS Monthly_High_Rating
FROM hr_analysis
GROUP BY Department
order by Monthly_High_Rating desc;

# 6.count number of department has non - traveler?

select Department,Business_Travel , count(*) as Count
from hr_analysis
where Business_Travel = 'Non-Travel'
group by Department,Business_Travel;

# 7.Find the distance form home to company (Max,Min,Avg,Total)?
	
SELECT 
    Department,
    MIN(Distance_From_Home_To_Company) AS Min_Distance,
    MAX(Distance_From_Home_To_Company) AS Max_Distance,
    AVG(Distance_From_Home_To_Company) AS Avg_Distance,
    COUNT(*) AS Number_Of_Employees
FROM hr_analysis
WHERE Distance_From_Home_To_Company BETWEEN 20 AND 50
GROUP BY Department;

# 8.How many peoples has 10 to 35 total working years experience by each department?	

SELECT Department,COUNT(*) AS Number_Of_Employees
FROM hr_analysis
WHERE Total_Working_Years BETWEEN 10 AND 35
GROUP BY Department;
