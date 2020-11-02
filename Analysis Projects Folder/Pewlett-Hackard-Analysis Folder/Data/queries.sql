-- Retirement eligibility 
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND	(hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Joining current_emp and dept_emp tables
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retirees
FROM current_emp AS ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee Information table
-- emp_no, last_name, first_name, gender, salary
-- rewrite this shit cause you're tired and not following directions
SELECT ce.emp_no, ce.last_name, ce.first_name, e.gender, s.salary
INTO emp_info
FROM current_emp AS ce
INNER JOIN salaries AS s
ON s.emp_no = ce.emp_no
LEFT JOIN employees AS e
ON e.emp_no = ce.emp_no;

-- Management table
-- dept_no, dept_name, emp_no, last_name, first_name, from_date, to_date

-- Department Retirees table
-- add dept_no and dept_name to current_emp

Select * FROM emp_info;
