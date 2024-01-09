CREATE TABLE titles(
	title_id VARCHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(20)
);

SELECT * FROM titles;

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
    emp_title VARCHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	sex VARCHAR(1)NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

SELECT * FROM employees

CREATE TABLE Departments(
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(20)
);

SELECT * FROM Departments;

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM dept_manager;

CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE salaries(
	emp_no INTEGER PRIMARY KEY NOT NULL,
    salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;

--1. employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
LEFT JOIN salaries ON employees.emp_no = salaries.emp_no

--2. List the first name, last name, and hire date for the employees who were hired in 1986. 
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE 
	hire_date >= '1986/01/01' 
	AND hire_date <= '1986/12/31';

--3. List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name. 

SELECT dept_manager.dept_no, Departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN Departments ON dept_manager.dept_no = Departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no

--4. List the department number for each employee along with that employee's
-- employee number, last name, first name, and department name. 

SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, Departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN Departments ON dept_emp.dept_no = Departments.dept_no

--5. List first name, last name, and sex of each employee whose first name is 
-- Hercules and whose last name begins with the letter B. 

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE
	first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
--6. List each employee in the Sales department, including their employee 
-- number, last name, and first name. 

SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_no = 'd007'

--7. List each employee in the Sales and Development departments, including
-- their employee number, last name, first name, and department name. 

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, Departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN Departments ON dept_emp.dept_no = Departments.dept_no
WHERE 
	dept_name = 'Sales'
	OR dept_name = 'Development'

--8. List the frequency counts, in descending order, of all the employee last names. In other words
--how many employees share each last name.

SELECT last_name, count(last_name) AS "dup_names"
FROM employees
Group By last_name
ORDER BY "dup_names" DESC;
