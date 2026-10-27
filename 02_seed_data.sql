USE company_db;

-- Insert 3 departments
INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'Engineering', 'Building A - Austin'),
(2, 'Human Resources', 'Building B - Chicago'),
(3, 'Sales & Marketing', 'Building C - New York');

-- Insert 10 employee records
INSERT INTO employees (emp_id, first_name, last_name, email, hire_date, job_title, salary, dept_id) VALUES
(101, 'Alice', 'Smith', 'alice.smith@company.com', '2021-03-15', 'Software Engineer', 85000.00, 1),
(102, 'Bob', 'Jones', 'bob.jones@company.com', '2020-06-01', 'Engineering Lead', 115000.00, 1),
(103, 'Charlie', 'Brown', 'charlie.brown@company.com', '2022-01-10', 'Junior Developer', 60000.00, 1),
(104, 'Diana', 'Prince', 'diana.prince@company.com', '2023-05-18', 'Technical Writer', 68000.00, NULL),
(105, 'Evan', 'Wright', 'evan.wright@company.com', '2019-11-20', 'HR Manager', 90000.00, 2),
(106, 'Fiona', 'Gallagher', 'fiona.g@company.com', '2021-08-01', 'HR Coordinator', 52000.00, 2),
(107, 'George', 'Clark', 'george.clark@company.com', '2018-04-12', 'Sales Director', 125000.00, 3),
(108, 'Hannah', 'Abbott', 'hannah.a@company.com', '2022-09-05', 'Account Executive', 72000.00, 3),
(109, 'Ian', 'Malcolm', 'ian.m@company.com', '2020-02-14', 'Sales Associate', 58000.00, 3),
(110, 'Julia', 'Roberts', 'julia.r@company.com', '2021-12-01', 'Software Engineer', 85000.00, 1);