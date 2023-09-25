USE [project]
s

-- create a join table
select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number;

--find the healthiest worker
select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker=0 
and Body_mass_index <25 and 
Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism_at_work)





--- compensation rate increase for non smokers
select count(*) as nonsmokers from Absenteeism_at_work where Social_smoker=0;

--- optimizing 1st query
select 
a.ID,
r.Reason,
case when Month_of_absence in (12,1,2) then 'Winter'
     when Month_of_absence in (3,4,5) then 'Spring'
     when Month_of_absence in (6,7,8) then 'Summer'
     when Month_of_absence in (9,10,11) then 'Fall'
     else 'Unknown' end as Season_name,
Case when Body_mass_index < 18.5 then 'Underweight'
	 when Body_mass_index > 18.5 and Body_mass_index <24.9 then 'Healthy weight'
	 when Body_mass_index > 25 and Body_mass_index < 30 then 'Overweight'
	 when Body_mass_index > 30 then 'Obese'
     else 'Unknown' end as BMI_category,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number;

