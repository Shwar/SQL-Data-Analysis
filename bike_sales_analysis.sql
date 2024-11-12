create database bike_sales;

show databases;

show tables;

-- View different columns
select * from bike_sales.addresses;
select * from businesspartners;
select * from employees;
select * from productcategories;
select * from productcategorytext;
select * from producttexts;
select * from	products;
select * from salesorders;
select * from salesorderitems;


-- Rename the column ``ï»¿ADDRESSID`

ALTER TABLE addresses
RENAME COLUMN `ï»¿ADDRESSID` TO `ADDRESSID`;

-- DROP  extra columns in empoyees table

ALTER TABLE employees drop column  `MyUnknownColumn_[0]`,
 drop column `MyUnknownColumn_[1]`,
drop column `MyUnknownColumn_[2]`,
drop column `MyUnknownColumn_[3]`, 
drop column `MyUnknownColumn_[4]`;

-- Products Analysis
-- Q1: Find the total number of products for each product category.

select products.PRODCATEGORYID,  count(*) as `Total` from products
group by products.PRODCATEGORYID order by Total desc ;


-- Q2: List the top 5 most expensive products.

select products.PRODUCTID, products.PRODCATEGORYID, PRICE from products
order by PRICE desc limit 5;

-- Q3: List the total sales amount (gross) for each product category.

	select  PRODCATEGORYID, sum(GROSSAMOUNT) as `Total_sales`  from products p
	left join salesorderitems s on
	p.PRODUCTID= s.PRODUCTID
	group by PRODCATEGORYID 
	order by Total_sales desc;


-- Q4: List the top 5 suppliers by total product sales.

	select SUPPLIER_PARTNERID, sum(s.QUANTITY) as Total_units_sold from products p
	inner join salesorderitems s on
	s.PRODUCTID =p.PRODUCTID
	group by SUPPLIER_PARTNERID 
	order by Total_units_sold desc ;

-- Q5: Find the total number of products created by each employee.

	select EMPLOYEEID, CREATEDBY,   count(PRODUCTID) as Total_products from employees e
	inner join products p on
	e.EMPLOYEEID = p.CREATEDBY
	group by CREATEDBY
	order by Total_products desc;

-- Q6: List the employees who have changed product details the most.

	select EMPLOYEEID, count(CHANGEDBY) as Total_changes from employees e
	inner join products p on e.EMPLOYEEID = p.CHANGEDBY
	group by CHANGEDBY order by Total_changes desc;

-- Sales Orders Items Analysis
-- Q7: Calculate the total gross amount for each sales order.

	select SALESORDERID, sum(GROSSAMOUNT) as `Total_Gross_Amount` from salesorderitems
	group  by SALESORDERID order by Total_Gross_Amount desc;

-- Q8: Find the sales order items for a specific product ID.

	select * from salesorderitems where
	 PRODUCTID = 'RC-1056';

-- Business Partners Analysis
-- Q9: How many business partners are there for each partner role?

	select PARTNERROLE,  count(PARTNERID) as Number_of_Business_partners from businesspartners
	group by PARTNERROLE;

-- Q10: List the top 5 companies with the most recent creation dates.

	select  COMPANYNAME, CREATEDAT from businesspartners order by CREATEDAT
	desc limit 5;

-- Employees Analysis
-- Q11: Find the number of employees for each sex.

	select SEX  , count(SEX) as 'No of employees' from  employees
	group by SEX order by `No of employees` ;

-- Q12: List the employees who comes from USA.

	select EMPLOYEEID, e.NAME_FIRST, e.NAME_LAST, e.PHONENUMBER, e.EMAILADDRESS, a.COUNTRY from employees e left join addresses a 
	on e.ADDRESSID = a.ADDRESSID where a.COUNTRY = 'US';

-- Product Categories Analysis
-- Q13: List all product categories along with their descriptions.

	select pc.PRODCATEGORYID, pct.SHORT_DESCR, pct.LONG_DESCR, pct.LONG_DESCR from productcategories pc
	join  productcategorytext pct
	on pc.PRODCATEGORYID = pct.PRODCATEGORYID;

	select p.PRODUCTID, p.PRODCATEGORYID,  pt.SHORT_DESCR, pt.MEDIUM_DESCR, pt.LONG_DESCR from products p
	join  producttexts pt 
	on p.PRODUCTID = pt.PRODUCTID;



-- Q14: Find all products that belong to the 'Mountain Bike' category.

	select p.PRODUCTID, p.PRODCATEGORYID,  pt.SHORT_DESCR, pt.MEDIUM_DESCR, pt.LONG_DESCR from products p
	join  producttexts pt 
	on p.PRODUCTID = pt.PRODUCTID
    where p.PRODCATEGORYID = 'MB';


-- Addresses Analysis
-- Q15: Count the number of addresses in each country.

select COUNTRY, count(POSTALCODE) AS 'No of addresses each country' from addresses
group by 	COUNTRY;

-- Q16: List all addresses in a specific city, e.g., 'New York'.

select POSTALCODE, STREET, CITY from addresses
where CITY = 'Chicago';



-- Q17: Find the number of business partners in each region.
-- Q18: List all addresses associated with a specific business partner.
-- Q19: Find the number of business partners in each region.
-- Q20: List all addresses associated with a specific business partner.

-- Sales Orders Analysis
-- Q21: Calculate the total gross amount for each sales organization.
-- Q22: Find the top 5 sales orders by net amount.
-- Q23: How many sales orders were created in the year 2018?

-- Combining Data from Multiple Tables
-- Q24: List the top 5 employees who have created the most sales orders.
-- Q25: Find the total sales amount (gross) for each product category.



