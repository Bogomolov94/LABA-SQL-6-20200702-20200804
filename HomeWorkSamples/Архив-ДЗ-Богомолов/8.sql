/*1. �������� ������� ��� �������� ������ ���� � ���������� (������ ����� ������� books_mbelko).
��� ��������� ������ � �����������
�������� � ����� ������� �� ���� ����������
�������� 3 ������������ ������ � ������� ��� ���� �������
�������� ����������� ������ ��������������� ���� ��������� ��������� ������� INFORMATION_SCHEMA.COLUMNS
�������� ����������� ������ �� ���������� ������ ������� (5 ������)*/

drop table if exists db_laba.dbo.books_abogomolov; -- �������� �������/��������� �������.

create table db_laba.dbo.books_abogomolov(
book_id int,
book_name varchar (100),
book_author varchar (50),
book_genre varchar (50));

insert into db_laba.dbo.books_abogomolov(
    book_id,
    book_name,
    book_author,
	book_genre)
values
(1,'1984','orwell','novel'),
(2,'the son','nesbo','crime novel'),
(3,'the witcher','sapkowski','fantasy');

--����������� ������ ��������������� ���������
select ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'books_abogomolov';

--����������� ������ �� ���������� �������
select * from db_laba.dbo.books_abogomolov;

/*2. � ��������� � ������ ������� ������� �������� ������� description � ����� ������ char(32)
�������� 3 ������������ ������ � ������� ��� ���� �������
�������� ����������� ������ ��������������� ���� ��������� ��������� ������� INFORMATION_SCHEMA.COLUMNS
�������� ����������� ������ �� ���������� ������ ������� (5 ������)*/

alter table db_laba.dbo.books_abogomolov add description char(32);

insert into db_laba.dbo.books_abogomolov(
    book_id,
    book_name,
    book_author,
	book_genre,
	description)
values
(4,'harry potter','rowling','fantasy','the boy who lived'),
(5,'my autobiography','sir alex ferguson','autobiography','the best coach'),
(6,'anna karenina','tolstoy','novel','panorama of life in Russia');

-- ����������� ������ ��������������� ���������
select ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'books_abogomolov';

--����������� ������ �� ���������� ������� (�����)
select * from db_laba.dbo.books_abogomolov;
--����������� ������ �� ���������� ������� (�� ����������� �������)
select * from db_laba.dbo.books_abogomolov
where book_id in (4,5,6);

/*3. � ��������� � ������ ������� ������� �������� ������ � ������������� �������, �� ��� � ������� description �������� ��������� �����:
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
(��������� ��� ����� ��� ������������ �������� ��� ������ ������� description)
�������� ������ ��� ����������� �������
�������� ����������� ������ ��������������� ���� ��������� ��������� ������� INFORMATION_SCHEMA.COLUMNS
�������� ����������� ������ �� ���������� ������ ������� (5 ������)*/

select len(replace('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '', '_')) as ����������_�������� 
/*������ �� ��������� � ����, ��� ��������� ����� �������� � ���� ������ 32 �������� (������� �� ������� ��� decription � ������� 2), ���������� ��������, ��� ���� �������� 32 �� ������� ��������.
������ ��� ���� ������ ��������� ������ ����, ����� �������� �� ������� �����������. �����: 125 �������.*/

--����� ������������ MODIFY, �� ���������, ��� ��� MS SQL Server ���� ������������ alter, ����� �������� ��� ������ �������
alter table db_laba.dbo.books_abogomolov alter column description char(125)

insert into db_laba.dbo.books_abogomolov(
    book_id,
    book_name,
    book_author,
	book_genre,
	description)
values
(7,'sql','bogomolov','textbook','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')

-- ����������� ������ ��������������� ���������
select ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'books_abogomolov';

--����������� ������ �� ���������� ������� (�����)
select * from db_laba.dbo.books_abogomolov;
--����������� ������ �� ���������� ������� (�� ����������� ������)
select * from db_laba.dbo.books_abogomolov
where book_id = 7;

/*4. �������� ����� ������� �� ������ ������� �� ������� ������� (�� ����� ��������� � 7� �������� �� ������� ������)
�������� ������� description � ������������ �� ����� �� ����� 3 ������� � �� ��������� �� ��������� N/A
�������� ������  ��� ����������� �������
�������� ����������� ������ ��������������� ���� ��������� ��������� ������� INFORMATION_SCHEMA.COLUMNS
�������� ����������� ������ �� ���������� ����� ����� ������� (5 ������)*/

drop table if exists db_laba.dbo.books_abogomolov_ver2

create table db_laba.dbo.books_abogomolov_ver2(
book_id int,
book_name varchar (100),
book_author varchar (50),
book_genre varchar (50),
description char (125) check (len(description)>=3) default 'N/A'); --�������� ������ � ���������. ����� ������� �� ������ ����. ���� ������� �����������. � ���� �� � ������� ������� ����� �������� ������� �����������.
--description char (125) default 'N/A' check (len(description)>=3))

insert into db_laba.dbo.books_abogomolov_ver2
select 
book_id,
book_name,
book_author,
book_genre,
COALESCE(description, 'N/A') -- ����� ����� ������������ COALESCE, �.�. ��������� �������, ��� �� ��������� descriprion ��������� �������� 'N/A'. �.�. ����� �� ���� null � n/a.
from db_laba.dbo.books_abogomolov;

--����������� ������ ��������������� ���������
select ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'books_abogomolov_ver2';

--����������� ������ �� ���������� ������� ����� �������
select * from db_laba.dbo.books_abogomolov_ver2;


/* ���� ������, ������� ��������, �������� �� ����������� �� ������� description
insert into db_laba.dbo.books_abogomolov_ver2(
    book_id,
    book_name,
    book_author,
	book_genre,
	description)
values
(8,'test','test','test','te')
������ ������. ����������� ��������.
*/


/*  ���� ������, ������� ��������, ������������ �� N/A �� ��������� � ������� description
insert into db_laba.dbo.books_abogomolov_ver2(
    book_id,
    book_name,
    book_author,
	book_genre)
values
(8,'test','test','test')

select * from db_laba.dbo.books_abogomolov_ver2;
��������� ������ �� ��������� N/A � description

delete from db_laba.dbo.books_abogomolov_ver2
where book_id = 8
*/



