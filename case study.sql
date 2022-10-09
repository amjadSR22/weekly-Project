use employees;

#Average salary by gender
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;  

#Employees whose contracts are ending on February 1st 2001
SELECT 
    e.first_name,
    e.last_name,
    t.to_date,
    t.from_date
FROM
    employees e
    join
    titles t ON e.emp_no = t.emp_no
WHERE t.to_date = '2001-02-01'
ORDER BY e.emp_no;

#Employees whose contracts are ending on February 1st 2001 (unique)
SELECT DISTINCT
    e.first_name,
    e.last_name,
    t.to_date,
    t.from_date
FROM
    employees e
    join
    titles t ON e.emp_no = t.emp_no
WHERE t.to_date = '2001-02-01' 
ORDER BY e.emp_no;
#Employees whose contracts are ending on February 1st 2001 with their department name
SELECT DISTINCT
    e.first_name,
    e.last_name,
    d.dept_name,
    t.to_date,
    t.from_date
FROM
    employees e
    join
    dept_emp dm on dm.emp_no =e.emp_no
    join
    departments d on dm.dept_no=d.dept_no
    join
    titles t ON e.emp_no = t.emp_no
WHERE t.to_date = '2001-02-01' 
ORDER BY e.emp_no;

#Years of service
SELECT distinct
    e.first_name, e.last_name,s.salary, DATEDIFF('2000-12-31',e.hire_date )/ 365, sum(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
group BY e.emp_no;

#Salary bonus for employees with more than 15 years of service
UPDATE employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
SET s.salary = s.salary+(s.salary*0.010)
WHERE e.hire_date = DATEDIFF('2000-12-31',e.hire_date )/ 365>15;

#Salary bonus for employees with more than 10 years of service
UPDATE employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
SET s.salary = s.salary+(s.salary*0.05)
WHERE e.hire_date = DATEDIFF('2000-12-31',e.hire_date )/ 365<15 and e.hire_date = DATEDIFF('2000-12-31',e.hire_date )/ 365>10 ;


#Salary bonus for employees whose contract are ending on February 1st 2001
UPDATE employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
        join
    titles t ON e.emp_no = t.emp_no
SET s.salary = s.salary+5000
WHERE  t.to_date = '2001-02-01';

