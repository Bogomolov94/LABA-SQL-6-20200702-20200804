/*1. �������� ��� ������ ������ � ������� ���������� ��������� ��������� �� ������ ������ ��� ������� 2016 ���� (5 ������)*/

 select
	x.order_id ord_id,
	x.item_id item_id,
	x.quantity QTY,
	x.order_date ord_date, 
	--x.total TOTAL, --- ������ ��� ������ ������ TOTAL �� ������. ��� ������������ �����������
	x.percentage_of_total_qty percentage_of_total_qty
from
	(
	select
		oi.order_id,
		oi.item_id,
		o.order_date,
		oi.quantity,
	--SUM(oi.quantity)
		--OVER(PARTITION BY oi.order_id) AS total ,  --- ���������� ������ 8 ����
		CAST(oi.quantity /
		     SUM(oi.quantity)
		     	OVER(PARTITION BY oi.order_id) * 100 AS DECIMAL(5,2)) AS percentage_of_total_qty
	from
		db_laba.dbo.order_items oi
	join db_laba.dbo.orders o on
		oi.order_id = o.order_id
		and YEAR(o.order_date) = 2016
		) x
order by
	4,
	1,
	5;

/*���� ��� ��������� ������� �� ������������. 
1-�� �� ������� ������ 103 (��������� �� ���������� item_id, quantity)

select *
     from
		db_laba.dbo.order_items oi 
		where oi.order_id = 103

2-�� �� �������� ���������� ����� (294 ��� � � �������� �������)

select o.order_id,
       oi.item_id
	from
		db_laba.dbo.orders o 
		inner join db_laba.dbo.order_items oi on
		o.order_id = oi.order_id
		where o.order_date BETWEEN '2016-01-01' AND '2016-12-31'
		*/


/*2. �������� 5 ������ ������ ��������� (����������: 2, 4, 6, 8 � 10) �������� �� ���������� ��������� ��������� �� ��� �����, �� ������ ������ �����  (5 ������)*/

select
	y.first_name sales_name,
	y.last_name sales_surname,
	y.phone sales_phone,
	y.total_qty,
	y.row_num
from
	(
	select
		x.first_name,
		x.last_name,
		x.phone,
		x.total_qty,
		row_number () over (order by x.total_qty desc) as row_num -- ��� ���������� �� ������� � �������
	from
		(
		select
			e.first_name, e.last_name, e.phone, sum (oi.quantity) total_qty
		from
			db_laba.dbo.order_items oi
		join db_laba.dbo.orders o on
			o.order_id = oi.order_id
		join db_laba.dbo.employees e on
			e.employee_id = o.salesman_id
		group by
			e.first_name, e.last_name, e.phone) x) y
where
	y.row_num <= 10  -- ��������� ������ ������ �� �������
	and y.row_num % 2 = 0; -- �������������� ����� ���������� � ������ �� ������ ������� �� 2. ����� ����� ������� � ���� ��������. ����� "% 2 = 0" ������, ����� ����� � ������ row_num �������� �� 2 ��� �������.

	/* ������ ������ ���������, ������� ��������� ����� ������ �� ������ ���-�� ������. �����, ��� ������ 9 �������. 
	�.�. ������ �� ������� ������, 10-�� �������� ��� ���, � ��������� ������ ���������  ������ ������ �� 2,4,6,8.
	select
			e.first_name, e.last_name, e.phone, sum(oi.quantity) as total_qty
		from
			db_laba.dbo.order_items oi
		join db_laba.dbo.orders o on
			o.order_id = oi.order_id
		left join db_laba.dbo.employees e on
			e.employee_id = o.salesman_id
			group by
			e.first_name, e.last_name, e.phone
		*/


/* 3. �������� ID ���������, ���� ������, ID ������ � ��������� ������, � ��� �� ��������� ����������� ������ �� ��������� � 3 ������ (���������: LAG � ����������) (5 ������) */

 SELECT
	o.customer_id cust_id,
	o.order_date ord_date,
	o.order_id ord_id,
	o2.price ord_price,
	LAG(o2.price,3,0) OVER(PARTITION BY o.customer_id ORDER BY o.order_date, o.order_id) AS prevVal_offset3 
	/*� ���� (https://docs.microsoft.com/en-us/sql/t-sql/functions/lag-transact-sql?view=sql-server-ver15) ��������, ��� LAG ����� ��� ���������. ��� ��������� �������������: 1) ���/����� (����������: �� ����� ���� �������������); 2)�������� �� ��������� (�.�., ���� NULL ������������)
	�� ��������� � LAG ������ �������� ����� 1, �.�. �������� �� 1 ������. ����������, ���� ���������� 3. � ������ �������� �������� 0, �.�. NULL ������� ����� ���� (�� ��� ��� ���� ���. � ������� ������ �� ����)
	*/
FROM
	db_laba.dbo.orders o
join (
	select
		sum(oi.unit_price * oi.quantity) price,
		oi.order_id
	from
		db_laba.dbo.order_items oi
	group by
		oi.order_id) o2 on
	o.order_id = o2.order_id


/* 4.������������� ���������� ��� ������� (5 ������)

������� id �������, ����, id � ��������� ������, � �����: 
1) ������� ����� ���������� �������� ������ � ���������� ������� ������ �������; 
2) ������� ����� ���������� �������� ������ � ���������� ���������� ������ �������*/

SELECT
o.customer_id,
o.order_date,
o.order_id,
o2.price,
o2.price - FIRST_VALUE(o2.price) 
OVER(PARTITION BY o.customer_id ORDER BY o.order_date, o.order_id) AS val_firstorder,
o2.price - LAST_VALUE(o2.price) 
OVER(PARTITION BY o.customer_id ORDER BY o.order_date, o.order_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS val_lastorder
FROM
db_laba.dbo.orders o
inner join (
select
sum(oi.unit_price * oi.quantity) price,
oi.order_id
from
db_laba.dbo.order_items oi
group by
oi.order_id) o2 on
o.order_id = o2.order_id;

/*����������: 
���� � ������� ���������������� ����� ������ � �������� ������� � ������ ������� ������ � ��������� ��������, �� ������, ��� FIRST � LAST VALUE ������� �� ���� ������ �������. ������ �� �����, ������ ������� ����� ��������� ���������� �� ����� ����� � �������� val_firstorder � val_lastorder.
���������� �������� ������ �����.��� ���������� �� ��������� ���������: � ������� FIRST_VALUE � LAST_VALUE �������� ����������� �� ������������ ������� ������, � ������������ �������(��� ������ � �����).�
"ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING" �� ������� ����������, ��� ������ ������ � ���� ���������� � ���������� ������� ������ � ������� ����� ������.
���� ����������� ��������� (�.�. ������ ��������), �� � ������� val_lastorder ������ �������������� price, �.�. ������� ������ ����� ����� ���������.
���, �������, ���� ��� ������ �����������. �� ����� �� ���� ������ ������.
*/

