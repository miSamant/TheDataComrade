-- ============================================================
-- Second Highest Salary - FAANG SQL Interview Question
-- ============================================================

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    employee_id  INTEGER PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    salary       INTEGER NOT NULL,
    department_id INTEGER,
    manager_id   INTEGER
);

INSERT INTO employee (employee_id, name, salary, department_id, manager_id) VALUES
(1,  'Emma Thompson',   3800, 1, 6),
(2,  'Daniel Rodriguez',2230, 1, 7),
(3,  'Olivia Smith',    2000, 1, 8),
(4,  'James Anderson',  5200, 2, 9),
(5,  'Sophia Martinez', 4700, 2, 9),
(6,  'William Johnson', 6100, 3, 10),
(7,  'Ava Williams',    3950, 1, 6),
(8,  'Benjamin Brown',  2850, 2, 9),
(9,  'Charlotte Davis', 7200, 3, 10),
(10, 'Ethan Wilson',    3300, 1, 6),
(11, 'Mia Garcia',      4100, 2, 9),
(12, 'Alexander Lee',   5600, 3, 10),
(13, 'Isabella Moore',  2900, 1, 7),
(14, 'Michael Taylor',  6100, 3, 10),
(15, 'Amelia Thomas',   3750, 2, 9),
(16, 'Lucas White',     4950, 1, 6),
(17, 'Harper Harris',   2200, 2, 7),
(18, 'Henry Clark',     5800, 3, 10),
(19, 'Evelyn Lewis',    3100, 1, 8),
(20, 'Sebastian Walker',6100, 3, 10),
(21, 'Abigail Hall',    4400, 2, 9),
(22, 'Jack Allen',      2000, 1, 8),
(23, 'Emily Young',     3800, 1, 6);




-- ============================================================
-- SOLUTION
-- ============================================================

WITH  BASE AS
(
SELECT *,RANK() OVER(ORDER BY salary DESC ) AS RANK FROM employee)

SELECT DISTINCT SALARY FROM BASE WHERE RANK=2