USE company_db;

-- 1. Basic SELECT: Retrieve all columns and rows from employees
-- Result: All 10 rows and all 8 columns.
SELECT * FROM employees;

-- 2. Column Aliasing & Math: Calculate a projected 10% bonus
-- Result: emp_id, full name, base salary, and a new computed column named annual_bonus.
SELECT emp_id, CONCAT(first_name, ' ', last_name) AS full_name, salary, salary * 0.10 AS annual_bonus
FROM employees;

-- 3. Filtering with WHERE: High earners (> $80,000)
-- Result: 5 rows (Bob, George, Evan, Alice, Julia).
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 80000.00;

-- 4. Range Filtering: Salaries between $60,000 and $90,000 inclusive
-- Result: 6 rows (Charlie, Diana, Alice, Julia, Hannah, Evan).
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary BETWEEN 60000.00 AND 90000.00;

-- 5. Pattern Matching with LIKE: Search for engineers
-- Result: Alice, Charlie, Bob, Julia.
SELECT first_name, last_name, job_title 
FROM employees 
WHERE job_title LIKE '%Engineer%' OR job_title LIKE '%Developer%';

-- 6. Membership with IN: Find employees in HR (dept_id = 2) or Sales (dept_id = 3)
-- Result: 5 rows (Evan, Fiona, George, Hannah, Ian).
SELECT e.first_name, e.last_name, d.dept_name 
FROM employees e
join departments d on e.dept_id = d.dept_id
WHERE e.dept_id IN (2, 3);

-- 7. Handling NULL Values: Find unassigned employees
-- Result: 1 row (Diana Prince).
SELECT first_name, last_name, dept_id 
FROM employees 
WHERE dept_id IS NULL;

-- 8. Multi-column Sorting: Sort by salary descending, then last name ascending
-- Result: All 10 rows ordered from highest salary ($125,000) to lowest ($52,000). 
-- Alice Smith and Julia Roberts (both $85,000) will be ordered alphabetically by last_name.
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC, last_name ASC;

-- 9. Aggregate Functions: Overview of company compensation
-- Result: A single row containing total count (10), min salary, max salary, sum, and average.
SELECT 
    COUNT(*) AS total_employees,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary,
    SUM(salary) AS total_payroll,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- 10. GROUP BY: Average salary per department
-- Result: 3 rows (dept_id 1, 2, 3) plus 1 row for NULL (Diana).
SELECT dept_id, COUNT(*) AS head_count, ROUND(AVG(salary), 2) AS avg_dept_salary
FROM employees
GROUP BY dept_id;

-- 11. HAVING Clause: Filter aggregated groups with average salary > $75,000
-- Result: Departments 1 and 3 (HR is excluded because its average is $71,000).
SELECT dept_id, ROUND(AVG(salary), 2) AS avg_dept_salary
FROM employees
WHERE dept_id IS NOT NULL
GROUP BY dept_id
HAVING AVG(salary) > 75000.00;

-- 12. INNER JOIN: Combine employees with their matching department name
-- Result: 9 rows (Diana Prince is excluded because her dept_id is NULL).
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 13. LEFT JOIN: Include ALL employees, even if they have no department assigned
-- Result: 10 rows (Diana Prince is included; dept_name and location show as NULL).
SELECT e.first_name, e.last_name, COALESCE(d.dept_name, 'Unassigned') AS dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 14. RIGHT JOIN: Ensure all departments appear even if an empty department exists
-- Result: Shows all 9 assigned employees matched to their departments.
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 15. Subquery in WHERE: Find all employees earning more than the company average
-- Result: 5 rows earning more than the overall average of $81,000 (Bob, Evan, George, Alice, Julia).
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 16. Subquery with IN: Employees working in Austin or Chicago
-- Result: Alice, Bob, Charlie, Evan, Fiona, Julia (departments 1 and 2).
SELECT first_name, last_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id FROM departments WHERE location LIKE '%Austin%' OR location LIKE '%Chicago%'
);

-- 17. Correlated Subquery: Employees earning more than their own department's average
-- Result: Bob Jones ($115,000 > Dept 1 avg of $86,250), Evan Wright ($90,000 > Dept 2 avg of $71,000), 
-- and George Clark ($125,000 > Dept 3 avg of $85,000).
SELECT e.first_name, e.last_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(sub.salary) 
    FROM employees sub 
    WHERE sub.dept_id = e.dept_id
);

-- 18. Scalar Subquery in SELECT: Display each employee alongside their department's total payroll
-- Result: 10 rows showing individual salary next to department payroll.
SELECT 
    e.first_name, 
    e.salary,
    (SELECT SUM(sub.salary) FROM employees sub WHERE sub.dept_id = e.dept_id) AS dept_payroll
FROM employees e;

-- 19. Pagination with LIMIT & OFFSET: Retrieve page 2 (rows 4 to 6) ordered by emp_id
-- Result: Rows 104, 105, 106.
SELECT emp_id, first_name, last_name 
FROM employees 
ORDER BY emp_id 
LIMIT 3 OFFSET 3;

-- 20. Window Function (MySQL 8.0+): Rank employees within each department by salary
-- Result: Employees partitioned by dept_id, ranked from 1 onwards by salary descending.
SELECT 
    emp_id, first_name, dept_id, salary,
    DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS dept_salary_rank
FROM employees
WHERE dept_id IS NOT NULL;