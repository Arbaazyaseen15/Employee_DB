-- 1. Create the database (if it doesn't already exist)
CREATE DATABASE IF NOT EXISTS company_db;

-- 2. Switch context to the new database
USE company_db;

-- 3. Drop existing tables if re-running the script (employees first due to foreign key dependency)
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 4. Create the departments table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- 5. Create the employees table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL CHECK (salary > 0),
    dept_id INT,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) 
        REFERENCES departments(dept_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);