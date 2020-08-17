/* 1. �������� ������ �� ����� ��������� � ������� employees_test_student ��������� ������������ ������� � �� ���������� ��������.
�������� ������ ��� ��������
����������: ����������� ������������ �������� (4 �����)*/

INSERT
	INTO
	db_laba.dbo.employees_test_student (employee_id,
	first_name,
	last_name,
	email,
	phone,
	hire_date,
	manager_id,
	job_title,
	student_name)
VALUES(999,
N'�����',
N'���������',
'ab@mail.com',
'777-777-777',
CAST('2019-08-12' as date),
1,
'Analyst',
'a.bogomolov');

--����������� ������
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'


/* ��� � �������� ������ DELETE. ����� ������ ����� INSERT
DELETE 
FROM db_laba.dbo.employees_test_student 
WHERE 
student_name = 'a.bogomolov'
*/


/*2. �������� �� ������� employees ��� ������ ��� ��������� Accountant � �������� ��������� � ������� employees_test_student.
�������� ������ ��� �������� (4 �����)*/

INSERT
	into
	db_laba.dbo.employees_test_student (employee_id,
	first_name,
	last_name,
	email,
	phone,
	hire_date,
	manager_id,
	job_title,
	student_name)
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	e.email,
	e.phone,
	e.hire_date,
	e.manager_id,
	e.job_title,
	'a.bogomolov'
FROM
	db_laba.dbo.employees e
WHERE
	e.job_title = 'Accountant' 

--����������� ������
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov' and t.job_title = 'Accountant'
--����������� ������ (��� ������. ������ ������ �� ���������)
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'

/* ���� ��������� ������, ������� ������ �������� ������ ��� ���� Accountant �� ������� employees, ������� ������ ������� � ���������
SELECT *
FROM
db_laba.dbo.employees e
WHERE e.job_title = 'Accountant'
*/

/*3. ��������� � ������� ������� ������� employees_test_student.first_name.
�������� ������ ��� �������� (4 �����) */
UPDATE
	db_laba.dbo.employees_test_student
SET
	first_name = UPPER(first_name)
WHERE student_name = 'a.bogomolov';

--����������� ������ 
SELECT t.first_name from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'
--����������� ������ (��� ������. ������ ������ �� ���������)
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'

/*4. �������� ������� employees_test_student.email ����� �������, ����� ������� ������ ����� (������: sample@cool.com => cool.com) ��� ���� ����������� ����� ������� ������� �� 5 �������� ������������.
�������� ������ ��� �������� (4 �����)*/

UPDATE
	db_laba.dbo.employees_test_student
SET
	email = SUBSTRING(email, CHARINDEX('@', email)+ 1, LEN(email))  
-- ����� � ������� SUBSTRING ������� ������ ��, ��� ���������, ��������� CHARINDEX ��� ������ ������� ������� ����� ����������� @. � LEN �����, ����� ������� ��� ����� ��� ������� �� �����.
WHERE
	student_name = 'a.bogomolov'
	AND LEN(last_name) <= 5;

--����������� ������
SELECT email, SUBSTRING(email, CHARINDEX('@', email)+ 1, LEN(email)) as domen
FROM
	db_laba.dbo.employees_test_student t
WHERE
	t.student_name = 'a.bogomolov'
	AND LEN(t.last_name) <= 5;
--����������� ������ (��� ������. ������ ������ �� ���������)
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'

/* ���� ��������� ������, ������� �������� ������, ������� ������ ���� ���������� � ���������� ���������� �������
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov' AND LEN(last_name) <= 5  --- RYAN Gray � ELLIOT James �������� ��� ����� ������
*/

/*5. ������� ������ �� ������� employees_test_student ��� ����������� � �������� ������� ����� 2 ����������� ������ ��� ���� �������� ������ ��� �������� (4 �����)*/

DELETE
FROM
	db_laba.dbo.employees_test_student
WHERE
	student_name = 'a.bogomolov' AND (LEN(phone) - LEN(REPLACE(phone, '2', '')) = 2)

--����������� ������ (����� �����). ������, ������ �������
SELECT *
FROM
	db_laba.dbo.employees_test_student t
WHERE
	student_name = 'a.bogomolov' AND (LEN(phone) - LEN(REPLACE(phone, '2', '')) = 2)
--����������� ������ (��� ������. ������ ������ �� ���������)
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov'

/* ���� ��������� ������, ������� �������� ������, ������� ������ ���� ���� ������� � ���������� ���������� �������
SELECT * from db_laba.dbo.employees_test_student t
WHERE t.student_name = 'a.bogomolov' AND (LEN(phone) - LEN(REPLACE(phone, '2', '')) = 2)  -- TYLER Ramirez �������� ��� ����� ������
*/


/*6* ���������� ��������� ���� � � ����� ������*/

SELECT LEN(N'������') - LEN(REPLACE(N'������', N'�', '')) as ����������_����_�_�_�����_������