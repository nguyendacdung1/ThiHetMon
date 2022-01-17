create database AZBank
go 
use AZBank
go
CREATE TABLE Customer
(
     CustomerID int PRIMARY KEY,
	 Name nvarchar(50),
	 Country nvarchar(50),
	 Phone nvarchar(15),
	 Email nvarchar(50)
)
GO
CREATE TABLE CustomerAccount
(
     AccountNumber char(9) PRIMARY KEY,
	 CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
	 Balance money not null,
	 MinAccount money 
)
GO
CREATE TABLE CustomerTransaction
(
     TransactionID int PRIMARY KEY,
	 AccountNumber char(9) FOREIGN KEY REFERENCES CustomerAccount(AccountNumber),
	 TransactionDate smalldatetime,
	 Amount money,
	 DepositorWithdraw bit,
	 CONSTRAINT CHK_Amount CHECK (Amount>0 and Amount<=100000000)
)
GO
INSERT INTO Customer values(01, N'Nguyễn Đắc Dũng', N'Hà Nội','0585009531','nguyendungmk9@gmail.com'),
                           (02, N'Đỗ Hải Yến', N'Hà Nội','0999999990','haiyen@gmail.com'),
						   (03, N'Huy Hoàng',N'Hưng Yên','0238735925','hoang1@gmail.com'),
						   (04,N'Đức Mạnh',N'Hà Nội', '0284572351','ahfhafu@gmail.com')
GO
INSERT INTO CustomerAccount values(520,01,'100000000000','100000'),
                                  (232,02,'45000000','100000'),
								  (123,03,'345000000','100000'),
								  (412,04,'141000000','100000'),
								  (888,01,'789000000000','100000')
GO
INSERT INTO CustomerTransaction values (1,520,'2022-01-17','2000000','1'),
                                       (2,123,'2022-01-10','200000','2'),
									   (3,412,'2022-01-10','1000000','3'),
									   (4,232,'2022-01-17','5000000','4'),
									   (5,888,'2022-01-11','1000000','1')
GO

SELECT*FROM Customer
WHERE Country=N'Hà Nội'

select Customer.Name,Customer.Phone,Customer.Email,CustomerAccount.AccountNumber,CustomerAccount.Balance
from Customer
join CustomerAccount
on Customer.CustomerID=CustomerAccount.CustomerID

CREATE VIEW vCustomerTransactions AS
SELECT Customer.Name,CustomerAccount.AccountNumber,CustomerTransaction.TransactionDate,CustomerTransaction.Amount,CustomerTransaction.DepositorWithdraw
FROM Customer
join CustomerAccount
on Customer.CustomerID=CustomerAccount.CustomerID
join CustomerTransaction
on CustomerAccount.AccountNumber=CustomerTransaction.AccountNumber

SELECT*FROM vCustomerTransactions

