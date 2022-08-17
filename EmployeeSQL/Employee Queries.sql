-- Data Analysis

-- 1. List the following details of each employee: 
--    employee number, last name, first name, sex, and salary.
--  Everything but salaries is in the employees table, and salaries has a FK to employees via emp_no.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no=salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
--  Looking at the employees table to get date formatting, then using where to set time frames. 

SELECT * FROM employees
LIMIT 10;

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31';

-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name.
--  dept_manager has dept_no and emp_no which are needed to connect to departments table to get
--  department name and to employees to get first and last names. 

SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, 
--    last name, first name, and department name.
--  dept_emp has foreign keys to both employees and departments, which has the other
--  fields required to be pulled in. Start there and join to those 2 tables. 

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and 
--    last names begin with "B."
--  No joins here as all fields are in employees. Wildcard % required for last names. 

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, 
--    and department name.
--  3 fields in employees table and the other only in departments table. Need to make an extra jump
--  to get there through dept_emp since it has the dept_no field. Then use where to set string parameter.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, 
--    last name, first name, and department name.
--  This is identical to above but add an OR statement to add employees in development department, too. 

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) 
--    in descending order.
--  Need to select last names from employees table and then count them, group by, and sort descending. 

SELECT employees.last_name, 
COUNT(last_name) AS "Count of Last Name"
FROM employees
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;