
# Case no. two
# Our goal is to save 20% of total salaries paid annually 
# Find the total annual salaries paid in the last year

# 1- Find out the total amount of salaries paid to each department

SELECT  d.dept_no, d.dept_name, SUM(salary) AS ' Dept Total Salaries in 2000'
FROM departments d JOIN  dept_emp e LEFT JOIN salaries s ON d.dept_no=e.dept_no and s.emp_no=e.emp_no
WHERE ( s.to_date BETWEEN '1999-12-31' AND '2000-12-31')
GROUP BY d.dept_no; 
 
SELECT  d.dept_no, d.dept_name, m.emp_no, m.first_name ,m.last_name, m.gender,m.hire_date, SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE (d.dept_name = 'development' ) and ( s.to_date BETWEEN '1999-12-31' AND '2000-12-31')
GROUP BY m.emp_no; 

SELECT  d.dept_no, d.dept_name, m.emp_no, m.first_name ,m.last_name , m.gender, SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE (d.dept_name = 'sales' )  and ( s.to_date BETWEEN '1999-12-31' AND '2000-12-31')
GROUP BY m.emp_no;

SELECT  d.dept_no, d.dept_name, m.emp_no, m.first_name ,m.last_name , m.gender, SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE (d.dept_name = 'production' )  and ( s.to_date BETWEEN '1999-12-31' AND '2000-12-31')
GROUP BY m.emp_no;

SELECT  d.dept_no, d.dept_name, m.emp_no, m.first_name ,m.last_name , m.gender, SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE (d.dept_name = 'Human Resources' )
and ( s.to_date BETWEEN '1999-12-31' AND '2000-12-31') 
GROUP BY m.emp_no;

 # Total dept salaries paid in 2000 = 6,550,550,602
 # 20% = 1,310,110,120.4

/*assess whether any service/contract is overpaid by comparing it to the salaries paid 
to the employees in the same department (also make sure to consider years of experience/work with the company).*/

# 50% off for <= two years of service and paid >= 100,000
# 30% off for <= five years of service and paid >= 100,000

SELECT distinct d.dept_name, m.emp_no, m.first_name ,m.last_name , m.gender,
 (DATEDIFF('2000-12-31',m.hire_date )/ 365) AS 'years of service', SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE( s.to_date BETWEEN '1999-12-31' AND '2000-12-31') 
and (s.salary>=100000) and ( DATEDIFF('2000-12-31',m.hire_date )/ 365 <=5) GROUP BY m.emp_no;

# The excel report shows that the total save (after 30% & 50% off) is 4,805,711.30 $

/*The salary deduction was not enough So, employees from 65 to 70 years
 will be sent to early retirement (who has born between 1952 - 1957) AND who served as for 8+ years */
 
SELECT distinct d.dept_name, m.emp_no, m.first_name ,m.last_name , m.gender,
m.birth_date ,(DATEDIFF('2000-12-31',m.hire_date )/ 365) AS 'years of service', SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE( s.to_date BETWEEN '1999-12-31' AND '2000-12-31') and ( DATEDIFF('2000-12-31',m.hire_date )/ 365 >=8) 
and (m.birth_date between '1952-02-06' and '1957-02-06') GROUP BY m.emp_no;
 
 # The excel report shows that the total save (after pushing to early retirement) is 1,023,811,879 $

/*The early retirement save was not enough So, Try to develop a strategy to reduce the cost of all contracts 
expiring within a year instead of downsizing departments. */
 
SELECT distinct d.dept_name, m.emp_no, m.first_name ,m.last_name , e.from_date,e.to_date,
m.birth_date , SUM(salary) AS 'Salaries in 2000'
FROM departments d JOIN dept_emp e ON d.dept_no=e.dept_no 
JOIN  employees m ON e.emp_no=m.emp_no JOIN salaries s ON m.emp_no=s.emp_no 
WHERE( s.to_date BETWEEN '1999-12-31' AND '2000-12-31') and (e.to_date = '2000-12-31')
GROUP BY m.emp_no;
# We decide to reduce the salary or lay off the employee while not being approved