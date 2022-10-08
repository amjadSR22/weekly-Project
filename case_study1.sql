use employees;

#The number of male and female employees in the company
select 
	count(case when upper(gender) = 'M' then 1 end) male,
	count(case when upper (gender)= 'F' then 1 end) female,
	count(emp_no) as 'total' from employees;

#The ratio of males to females hired in the last 5 years
SELECT
    COUNT(IF(gender = 'M', 1, NULL)) count_male,
    COUNT(IF(gender = 'F', 1, NULL)) count_female,
    COUNT(IF(gender = 'M', 1, NULL))/COUNT(IF(gender = 'F', 1, NULL)) as ratio
FROM employees where hire_date > date_sub("2000-12-31",interval 5 year);

#list of the departments that have the highest gaps between males and females in descending order
select
	dept_name,
	COUNT(IF(gender = 'M', 1, NULL)) count_male,
    COUNT(IF(gender = 'F', 1, NULL)) count_female,
    COUNT(IF(gender = 'M', 1, NULL))/COUNT(IF(gender = 'F', 1, NULL)) as ratio
from dept_emp 
join employees		 on employees.emp_no 	= dept_emp.emp_no
join departments 	 on departments.dept_no = dept_emp.dept_no 
group by dept_name order by ratio desc;
	
#salary gap between females and males in each department 
select
	e.gender, d.dept_name, avg (salary)
from salaries s 
join employees e 	on e.emp_no 	=	s.emp_no 
join dept_emp dm 	on dm.emp_no 	=	e.emp_no
join departments d 	on dm.dept_no	=	d.dept_no
group by dept_name, gender;

#show dept_emp and depratments tables
select *  from dept_emp;
select *  from departments;