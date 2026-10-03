CREATE DATABASE finance_tracker;
USE finance_tracker;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);	

CREATE TABLE ACCOUNTS (
ACCOUNT_ID INT AUTO_INCREMENT PRIMARY KEY,
user_id Int NOT NULL,
ACCOUNT_NAME VARCHAR(100) NOT NULL,
balance DECIMAL(10, 2) default 0.00,
FOREIGN KEY (user_id) REFERENCES Users(user_id));

CREATE TABLE Categories(
CATEGORY_ID INT auto_increment PRIMARY KEY,
CATEGORY_NAME varchar(50) NOT NULL,
CATEGORY_TYPE ENUM ('INCOME','EXPENSE') NOT NULL);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    category_id INT NOT NULL,  
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATE NOT NULL,
    description VARCHAR(255),  
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) 
);

INSERT INTO Users (username, email) 
VALUES ('JohnDoe', 'john@example.com');
INSERT INTO Categories (category_name, category_type) 
VALUES 
('Salary', 'income'), 
('Groceries', 'expense'), 
('Rent', 'expense');
INSERT INTO ACCOUNTS(USER_ID,ACCOUNT_NAME) VALUES ('1','CHASE CHECKING');
INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description)
VALUES (1, 1, 3000.00, '2023-10-01', 'October Salary');
SELECT * FROM ACCOUNTS;
SELECT * FROM Transactions;
SELECT * FROM USERS;
SELECT * FROM CATEGORIES;
-- TRIGGERS
DELIMITER //
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    UPDATE Accounts 
    SET balance = balance + NEW.amount 
    WHERE account_id = NEW.account_id;
END; //
DELIMITER ;
DELETE FROM Transactions;
INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description)
VALUES (1, 1, 3000.00, '2023-10-01', 'October Salary');
INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description)
VALUES (1, 2, -150.00, '2023-10-05', 'Walmart Groceries'), (1, 3, -1200.00, '2023-10-06', 'October Rent');
-- VIEWS
CREATE VIEW Category_Totals_View AS
SELECT c.category_name, c.category_type,SUM(t.amount) AS total_amount
FROM Transactions t
JOIN Categories c ON t.category_id = c.category_id
GROUP BY c.category_name, c.category_type;
SELECT * FROM Category_TotalS_View;
-- PROCEDURES 
DELIMITER //
CREATE PROCEDURE AddTransaction(
    IN p_account_id INT,
    IN p_category_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_description VARCHAR(255)
)
BEGIN
    -- We use CURDATE() to automatically use today's date!
    INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description)
    VALUES (p_account_id, p_category_id, p_amount, CURDATE(), p_description);
END; //
DELIMITER ;
CALL AddTransaction(1, 2, -20.00, 'Starbucks Coffee');