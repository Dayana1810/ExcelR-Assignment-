SELECT * FROM employees;
#Q1-A
SELECT DISTINCT employeeNumber, firstname, lastname FROM employees
WHERE jobTitle = "Sales rep"
AND reportsto = 1102;


#Q1-B
SELECT * FROM productlines;
SELECT productline FROM productlines
WHERE productline LIKE "%cars";


#Q2
SELECT * FROM customers;
SELECT customernumber, customername, 
 CASE 
  WHEN Country in ("USA", "Canada") THEN "North America"
  WHEN Country in ("UK", "France", "Germany") THEN "Europe"
  ELSE "Other"
END AS Customersegment FROM customers;


#Q3-A
SELECT * FROM orderdetails;
SELECT productcode, SUM(quantityOrdered) AS total_ordered FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityOrdered)
ORDER BY total_ordered DESC
LIMIT 10;


#Q3-B
SELECT * FROM payments;
SELECT monthname(paymentdate) AS Payment_month,
count(paymentdate) AS num_payments FROM payments 
GROUP BY 1
HAVING num_payments > 20
ORDER BY num_payments DESC;


#Q4-A
CREATE TABLE Customer (Customer_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(50) not null,
 last_name VARCHAR(50) not null, email VARCHAR(250)	UNIQUE, phone_number VARCHAR(20));

INSERT INTO Customer (first_name, last_name, email, phone_number) 
 VALUES("Virat ", "Kohli", "viratkohli18@gmail.com", 9878684818),
	   ("Rohit", "Sharma", "rohitsharma45@gmail.com", 9585754745),
       ("Mitchel", "Starc", "mitchelstarc56@gmail.com",8975565742);

SELECT * FROM Customer;


#Q4-B
Create table Orders
   (orders_id int auto_increment primary key,
    customer_id int,
    order_date date,
    total_amount decimal (10,2),
    check (total_amount > 0),
    foreign key(customer_id) references Customer(customer_id));
   
describe orders;

INSERT INTO Orders(Customer_id, order_date, total_amount)
VALUES (1,"2025-10-30",1000),(2,"2025-10-20",2000),
	   (4,"2025-10-10",3000),(1,"2025-09-12",4000);

select * from orders;


#Q5
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
show tables;

SELECT Country, count(ordernumber) AS Order_Count from customers
JOIN Orders
On customers.customernumber= orders.customernumber
GROUP BY Country 
ORDER BY ORDER_COUNT DESC
LIMIT 5;


#Q6
CREATE TABLE PROJECT(EmployeeID int auto_increment primary key,
Full_Name varchar(50) not null,
Gender enum('Male','Female'),
Manger_Id INT);

INSERT INTO PROJECT(EmployeeID,Full_Name, Gender, Manger_ID)
VALUES (1,"Pranaya", "Male",3),(2,"Priyanka","Female",1),(3,"Preety","Female",null),
(4,"Anurag","Male",1),(5,"Sambit","Male",1),(6,"Rajesh","Male",3),(7,"Hina","Female",3);

Select * from project;

SELECT Table_2.Full_Name AS Manager, Table_1.Full_Name AS Employee FROM PROJECT Table_1
JOIN PROJECT Table_2
on Table_2.EmployeeID=Table_1.Manger_Id
ORDER BY 1;


#Q7
CREATE TABLE Facility(Facility_Id INT, 
Name varchar(20),
State varchar(20),
Country varchar(20));

Select * from Facility;
describe Facility;

ALTER Table Facility Modify Facility_Id int not Null auto_increment,
ADD primary key(Facility_Id);
ALTER Table Facility ADD City Varchar(20) not Null After Name;
describe Facility;


#Q8
SELECT * FROM Productlines;
SELECT * FROM Products;
SELECT * FROM orderdetails;
SELECT * FROM orders;

CREATE VIEW product_category_sales AS
SELECT pl.Productline,SUM(od.quantityOrdered *od.priceEach) As Total_Sales,
count(DISTINCT od.ordernumber) As Numbers_of_orders
from productlines pl
join products p on pl.productline = p.productline
join orderdetails od on od.productcode = p.productcode
Group by pl.Productline;

select * from product_category_sales;


#Q9
SELECT Year(p.paymentDate) As Year, C.Country, 
Concat(Round(sum(p.amount)/1000,0),"K") As Total_Amount 
FROM customers c
join payments p on c.customerNumber = p.customerNumber
Where Country = "France" 
Group by 1,2;

Call get_country_payments(2003,"France");


#Q10-A
SELECT * FROM Customers;
SELECT * FROM orders;

Select c.customername, Count(o.ordernumber) AS Order_Count,
dense_rank() over(order by Count(o.ordernumber) desc) order_frequency_rnk
From customers c
join orders o On c.customerNumber= o.customerNumber
group by c.customerName
order by count(o.ordernumber) desc;


#Q10-B
Select * from orders;
Select year(orderDate) Year,monthname(orderDate) Month,
Count(orderNumber) As Total_Orders,
Concat(Round((Count(orderNumber)-lag(Count(orderNumber)) over(order by Year(orderDate)))/
lag(Count(orderNumber)) over(order by Year(orderdate))*100,0),"%") YOY
From Orders
Group by Year, Month;


#Q-11
Select * from Products;
Select avg(buyprice) From Products;
Select productline, count(productline) Total
From Products
Where buyprice >(Select avg(buyprice) From Products)
Group by 1 Order by Total Desc;

#Q-12
Create table Emp_EH
(Empid int primary key,
EmpName Varchar(100), EmailAddress Varchar(100));

Select * From Emp_EH;


#Q-13
Create Table Emp_BIT(Name varchar(50), Occupation varchar(50), Working_Date date, Working_Hours Int);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', -13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', -12),  
('Antonio', 'Business', '2020-10-04', -11);

Select * From Emp_BIT;

-- Trigger--
CREATE DEFINER=`root`@`localhost` TRIGGER `emp_bit_BEFORE_INSERT` BEFORE INSERT ON `emp_bit` FOR EACH ROW BEGIN
if new.Working_Hours<0 Then
set new.Working_hours=abs(new.Working_Hours);
end if;
END


-- Thank You --



















