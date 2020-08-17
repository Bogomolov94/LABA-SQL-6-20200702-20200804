/*1. �������� ������� � ������ invoices_<name> (���������� �������� ������� ��������������) 
������� ������ ��������� ��� ����������� ����������� � ��������� �����. (5 ������)*/

DROP TABLE IF EXISTS db_laba.dbo.invoices_bogomolov;

CREATE TABLE db_laba.dbo.invoices_bogomolov
(
    invoice_id int NOT NULL,
    invoice_date date NOT NULL,
    order_id int NOT NULL,
    currency varchar(3) NOT NULL,
    payment_method varchar(10) NOT NULL,
    paymenent_date date NOT NULL, 
    is_paid bit NOT NULL default 0,
    invoice_comment varchar(100),    
    CONSTRAINT PK_invoices_bogomolov_invoice_id PRIMARY KEY (invoice_id),
    CONSTRAINT FK_invoices_bogomolov_orders FOREIGN KEY( order_id) REFERENCES db_laba.dbo.orders( order_id ));

--check
Select C.*, (Select definition From sys.default_constraints Where object_id = C.object_id) As dk_definition,
(Select definition From sys.check_constraints Where object_id = C.object_id) As ck_definition,
(Select name From sys.objects Where object_id = D.referenced_object_id) As fk_table,
(Select name From sys.columns Where column_id = D.parent_column_id And object_id = D.parent_object_id) As fk_col
From sys.objects As C
Left Join (Select * From sys.foreign_key_columns) As D On D.constraint_object_id = C.object_id 
Where C.parent_object_id = (Select object_id From sys.objects Where type = 'U'
And name = 'invoices_bogomolov');

--��������� ������� �������

    INSERT into db_laba.dbo.invoices_bogomolov
    (invoice_id,
    invoice_date,
    order_id,
    currency,
    payment_method,
    paymenent_date,
    invoice_comment)
    VALUES 
    (1,CAST('2017-02-12' as date),104,'USD','Cash',CAST('2017-02-20' as date),'test'),
    (2,CAST('2016-12-03' as date),105,'EUR','Ewallet',CAST('2016-12-30' as date),'test n');

    /*
    (3,CAST('2000-01-01' as date),106,'RUR','Cash',CAST('2000-01-20' as date),'test number 3'); -- ����� �������� ����� � �������� orders (� ��� ��� 106 ������). Insert ����������. ���� ��������� �������� - ������ ������� �� ��������.

     SELECT * 
       FROM db_laba.dbo.orders
       order by 1 desc
       */

DELETE FROM db_laba.dbo.invoices_bogomolov
WHERE invoice_id in (1,2,3)

SELECT * 
FROM db_laba.dbo.invoices_bogomolov


/*2. �������� ������� � ������ invoices_details_<name> (���������� �������� ������� ��������������) 
������� ������ ��������� ��� ����������� ����������� � ����� � �������� invoices_<name>.
����������������� ��������� ����������� ����������� ������ (5 ������)*/

 DROP TABLE IF EXISTS db_laba.dbo.invoices_details_bogomolov;

      CREATE TABLE db_laba.dbo.invoices_details_bogomolov
(
    line_id int NOT NULL,
    invoice_id int NOT NULL,
    product_id int NOT NULL,
    quantity decimal (8,2) NOT NULL,
    CONSTRAINT PK_invoices_details_bogomolov_line_id_invoice_id PRIMARY KEY (line_id,invoice_id),
    CONSTRAINT FK_invoices_details_products_bogomolov FOREIGN KEY( product_id )
      REFERENCES db_laba.dbo.products ( product_id ),
    CONSTRAINT FK_invoices_details_invoices_bogomolov FOREIGN KEY( invoice_id )
      REFERENCES db_laba.dbo.invoices_bogomolov ( invoice_id ));
     -- ON DELETE CASCADE);  --- ������ �������

      --check
Select C.*, (Select definition From sys.default_constraints Where object_id = C.object_id) As dk_definition,
(Select definition From sys.check_constraints Where object_id = C.object_id) As ck_definition,
(Select name From sys.objects Where object_id = D.referenced_object_id) As fk_table,
(Select name From sys.columns Where column_id = D.parent_column_id And object_id = D.parent_object_id) As fk_col
From sys.objects As C
Left Join (Select * From sys.foreign_key_columns) As D On D.constraint_object_id = C.object_id 
Where C.parent_object_id = (Select object_id From sys.objects Where type = 'U'
And name = 'invoices_details_bogomolov');

      
      --�������� ������� ������� �������

    INSERT into db_laba.dbo.invoices_details_bogomolov
    (line_id,
    invoice_id,
    product_id,
    quantity)
    VALUES 
    (7,2,55,50),
    (13,1,33,19);

    DELETE FROM db_laba.dbo.invoices_details_bogomolov
    WHERE invoice_id < 15

        select *
    from db_laba.dbo.invoices_details_bogomolov


    --���� �� �������� invoice_id �� db_laba.dbo.invoices_bogomolov (���� ������������ CASCADE)
    
SELECT * 
FROM db_laba.dbo.invoices_bogomolov  

DELETE FROM db_laba.dbo.invoices_bogomolov  
WHERE invoice_id = 1

SELECT * 
FROM db_laba.dbo.invoices_details_bogomolov -- ������ �� invoice_id = 1 ������� �� �������


     --���� �� �������� invoice_id �� db_laba.dbo.invoices_bogomolov (��� CASCADE)

DELETE FROM db_laba.dbo.invoices_bogomolov  
WHERE invoice_id = 1  -- ����� ������. �� ��������� ������� ��-�� ������ � �������� db_laba.dbo.invoices_details_bogomolov

     --���� �� �������� line_id �� ��������������� invoice_id

     INSERT into db_laba.dbo.invoices_details_bogomolov
    (line_id,
    invoice_id,
    product_id,
    quantity)
    VALUES 
    (13,3,33,19);  -- ����� ������, �.�. ��� ������ invoice_id � ������� db_laba.dbo.invoices_bogomolov  
     
     --���� �� �������� line_id �� ��������������� product_id

     select *
     from db_laba.dbo.products
     order by 1 desc


     INSERT into db_laba.dbo.invoices_details_bogomolov
    (line_id,
    invoice_id,
    product_id,
    quantity)
    VALUES 
    (14,1,289,100);  -- ����� ������, �.�. ��� ������ product_id � ������� db_laba.dbo.products

    -- ����� ������ �������� ��� ���� line_id ��� invoice_id = 2.

 INSERT into db_laba.dbo.invoices_details_bogomolov
    (line_id,
    invoice_id,
    product_id,
    quantity)
    VALUES 
    (13,2,33,19);  

    SELECT * 
FROM db_laba.dbo.invoices_details_bogomolov

DELETE FROM db_laba.dbo.invoices_details_bogomolov 
WHERE line_id=13 and invoice_id=2 


/*3. ��������� ���� ������ ������� ��� �������� (�� ����� ������������ ������� �� ������� 1 � 2), �������� ������������� ������� ����� ��������� 
���������� �������, ��� �������, ��� � ������� ��������
��� ���������� ������������� ������ ���������� ���������� (5 ������)*/

CREATE VIEW dbo.orders_details_by_year_abogomolov
AS
SELECT
    COUNT (o.order_id) as orders_num,
    YEAR(o.order_date) as order_year,
    e.first_name,
    e.last_name
FROM
    db_laba.dbo.orders as o
inner join db_laba.dbo.employees as e on -- �.�. ����� ���������� �������, �� ������  inner
    o.salesman_id = e.employee_id
GROUP BY
    YEAR(o.order_date),
    e.first_name,
    e.last_name;

SELECT* 
FROM dbo.orders_details_by_year_abogomolov

DROP VIEW if exists dbo.orders_details_by_year_abogomolov

/*4. �������� ������������� �� ������ 3, �������� � ����� ���, ������� � ������� ��������� ��� �������� (5 ������)*/

ALTER VIEW dbo.orders_details_by_year_abogomolov AS
SELECT
    COUNT (o.order_id) as orders_num,
    YEAR(o.order_date) as order_year,
    e.first_name,
    e.last_name,
    m.first_name as manager_name,
    m.last_name as manager_surname,
    m.phone as manager_phone
FROM
    db_laba.dbo.orders as o
inner join db_laba.dbo.employees as e on
    o.salesman_id = e.employee_id
inner join db_laba.dbo.employees as m on
    m.employee_id = e.manager_id
GROUP BY
    YEAR(o.order_date),
    e.first_name,
    e.last_name,
    m.first_name,
    m.last_name,
    m.phone;

SELECT* 
FROM dbo.orders_details_by_year_abogomolov

DROP VIEW if exists dbo.orders_details_by_year_abogomolov

/* ���� ��������� ��������, ��������� �� �������� ��.
select * 
from db_laba.dbo.employees
where last_name = 'Freeman'  -- � ���� manager_id = 48, a employee_id = 64

select * 
from db_laba.dbo.employees
where employee_id = 48

select 
    COUNT (order_id) as orders_num,
    YEAR(order_date) as order_year,
    salesman_id
from db_laba.dbo.orders
where salesman_id = 64
GROUP BY
    YEAR(order_date),
    salesman_id
*/