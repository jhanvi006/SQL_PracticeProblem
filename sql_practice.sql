mysql> create database demo;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book         |
| address_book_service |
| book_store           |
| demo                 |
| emp_payroll_service  |
| greeting             |
| information_schema   |
| lms                  |
| mysql                |
| payroll_service      |
| payroll_services     |
| performance_schema   |
| sakila               |
| sys                  |
| user_registration    |
| world                |
+----------------------+
16 rows in set (0.00 sec)

mysql> use demo;
Database changed

mysql> CREATE TABLE departments
    -> ( department_id int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   department_name varchar(50) NOT NULL
    -> );
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE employees
    -> ( employee_id int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   employee_name varchar(50) NOT NULL,
    ->   department_id int(10),
    ->   salary decimal(6,2),
    ->   FOREIGN KEY (department_id) REFERENCES departments(department_id)
    -> );
Query OK, 0 rows affected, 2 warnings (0.05 sec)

mysql> insert into departments(department_name) values ('marketing'), ('engineering'), ('accounts');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from departments;
+---------------+-----------------+
| department_id | department_name |
+---------------+-----------------+
|             1 | marketing       |
|             2 | engineering     |
|             3 | accounts        |
+---------------+-----------------+
3 rows in set (0.00 sec)

mysql> insert into employees(employee_name, department_id, salary)
    -> values
    -> ('Sneha', 2, 3500),
    -> ('Ketan', 3, 4000);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employees;
+-------------+---------------+---------------+---------+
| employee_id | employee_name | department_id | salary  |
+-------------+---------------+---------------+---------+
|           1 | Sneha         |             2 | 3500.00 |
|           2 | Ketan         |             3 | 4000.00 |
+-------------+---------------+---------------+---------+
2 rows in set (0.00 sec)

 insert into employees(employee_name, department_id, salary)
    -> values
    -> ('Ammy', 3, 4500),
    -> ('Kush', 3, 5500),
    -> ('Jia', 2, 4500);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from employees;
+-------------+---------------+---------------+---------+
| employee_id | employee_name | department_id | salary  |
+-------------+---------------+---------------+---------+
|           1 | Sneha         |             2 | 3500.00 |
|           2 | Ketan         |             3 | 4000.00 |
|           5 | Ammy          |             3 | 4500.00 |
|           6 | Kush          |             3 | 5500.00 |
|           7 | Jia           |             2 | 4500.00 |
+-------------+---------------+---------------+---------+
5 rows in set (0.00 sec)

mysql> select * from employees cross join departments;
+-------------+---------------+---------------+---------+---------------+-----------------+
| employee_id | employee_name | department_id | salary  | department_id | department_name |
+-------------+---------------+---------------+---------+---------------+-----------------+
|           1 | Sneha         |             2 | 3500.00 |             3 | accounts        |
|           1 | Sneha         |             2 | 3500.00 |             2 | engineering     |
|           1 | Sneha         |             2 | 3500.00 |             1 | marketing       |
|           2 | Ketan         |             3 | 4000.00 |             3 | accounts        |
|           2 | Ketan         |             3 | 4000.00 |             2 | engineering     |
|           2 | Ketan         |             3 | 4000.00 |             1 | marketing       |
|           5 | Ammy          |             3 | 4500.00 |             3 | accounts        |
|           5 | Ammy          |             3 | 4500.00 |             2 | engineering     |
|           5 | Ammy          |             3 | 4500.00 |             1 | marketing       |
|           6 | Kush          |             3 | 5500.00 |             3 | accounts        |
|           6 | Kush          |             3 | 5500.00 |             2 | engineering     |
|           6 | Kush          |             3 | 5500.00 |             1 | marketing       |
|           7 | Jia           |             2 | 4500.00 |             3 | accounts        |
|           7 | Jia           |             2 | 4500.00 |             2 | engineering     |
|           7 | Jia           |             2 | 4500.00 |             1 | marketing       |
+-------------+---------------+---------------+---------+---------------+-----------------+
15 rows in set (0.00 sec)

mysql> select  employees.employee_id, employees.employee_name, departments.department_name from employees, departments
    -> where employees.department_id = departments.department_id;
+-------------+---------------+-----------------+
| employee_id | employee_name | department_name |
+-------------+---------------+-----------------+
|           1 | Sneha         | engineering     |
|           7 | Jia           | engineering     |
|           2 | Ketan         | accounts        |
|           5 | Ammy          | accounts        |
|           6 | Kush          | accounts        |
+-------------+---------------+-----------------+
5 rows in set (0.00 sec)

mysql> select emp.employee_id, emp.employee_name, emp.salary, dept.department_name
    -> from employees as emp left join departments as dept
    -> on emp.department_id = dept.department_id;
+-------------+---------------+---------+-----------------+
| employee_id | employee_name | salary  | department_name |
+-------------+---------------+---------+-----------------+
|           1 | Sneha         | 3500.00 | engineering     |
|           2 | Ketan         | 4000.00 | accounts        |
|           5 | Ammy          | 4500.00 | accounts        |
|           6 | Kush          | 5500.00 | accounts        |
|           7 | Jia           | 4500.00 | engineering     |
+-------------+---------------+---------+-----------------+
5 rows in set (0.00 sec)

mysql> select emp.employee_id, emp.employee_name, emp.salary, dept.department_name
    -> from employees as emp right join departments as dept
    -> on emp.department_id = dept.department_id;
+-------------+---------------+---------+-----------------+
| employee_id | employee_name | salary  | department_name |
+-------------+---------------+---------+-----------------+
|        NULL | NULL          |    NULL | marketing       |
|           1 | Sneha         | 3500.00 | engineering     |
|           7 | Jia           | 4500.00 | engineering     |
|           2 | Ketan         | 4000.00 | accounts        |
|           5 | Ammy          | 4500.00 | accounts        |
|           6 | Kush          | 5500.00 | accounts        |
+-------------+---------------+---------+-----------------+
6 rows in set (0.00 sec)

mysql> select count(employee_id), department_id from employees group by department_id;
+--------------------+---------------+
| count(employee_id) | department_id |
+--------------------+---------------+
|                  2 |             2 |
|                  3 |             3 |
+--------------------+---------------+
2 rows in set (0.00 sec)

mysql> create INDEX dept on employees (department_id);
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select *  from employees where department_id=3;
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref   | rows | filtered | Extra |
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | employees | NULL       | ref  | dept          | dept | 5       | const |    3 |   100.00 | NULL  |
+----+-------------+-----------+------------+------+---------------+------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.01 sec)

