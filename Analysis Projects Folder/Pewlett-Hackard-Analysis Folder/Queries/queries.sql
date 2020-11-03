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
-- emp_no, last_name, first_name, gender, salary, to_date
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees AS e
	INNER JOIN salaries AS s
		ON s.emp_no = e.emp_no
	INNER JOIN dept_emp AS de
		ON de.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- Management table
-- dept_no, dept_name, emp_no, last_name, first_name, from_date, to_date
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- Department Retirees table
-- add dept_no and dept_name to current_emp
-- emp_no, first_name, last_name, dept_name
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON de.emp_no = ce.emp_no
	INNER JOIN departments AS d
		ON d.dept_no = de.dept_no;

-- Sales Team Table
-- emp_no, first_name, last_name, dept_name FROM di where dept_name = Sales 
SELECT *
FROM dept_info
WHERE dept_name = 'Sales';

-- Sales and Development Table
SELECT *
FROM dept_info
WHERE dept_name IN('Sales', 'Development');
