DROP DATABASE IF EXISTS ShopDB; 
CREATE DATABASE ShopDB; 
USE ShopDB;

CREATE TABLE shop_product 
(
    ProductID INT NOT NULL PRIMARY KEY,
    Name NVarChar(100),
    Description NVarChar(200),
    Stock INT,
    Price DECIMAL(8,2) -- 8 digits total + 2 decimals (xxxxxx.xx) 
);


CREATE TABLE shop_order
(
    OrderID INT NOT NULL PRIMARY KEY,
    OrderDate Datetime NOT NULL   
);


CREATE TABLE shop_orderDetails
(
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID),        
    FOREIGN KEY (OrderID) REFERENCES shop_order (OrderID),    
    FOREIGN KEY (ProductID) REFERENCES shop_product (ProductID)    
);


-- Test data
INSERT INTO shop_product VALUES (1,'Mr. Burns Statue', 'Awesome and hilarious', 10, 4999.95);
INSERT INTO shop_product VALUES (2,'Bilbo Baggins Statue', 'Serious and precious', 3, 249.95);
INSERT INTO shop_product VALUES (3,'Drunken Barney', 'Drunk and sleeping', 30, 1000.95);

INSERT INTO shop_order VALUES (1001, '2020-04-22 10:00');
INSERT INTO shop_order VALUES (1002, '2020-04-12 08:20');


INSERT INTO shop_orderDetails VALUES (1001, 1, 2);
INSERT INTO shop_orderDetails VALUES (1001, 3, 7);

INSERT INTO shop_orderDetails VALUES (1002, 2, 1);
INSERT INTO shop_orderDetails VALUES (1002, 3, 5);




-- Create View (virtual table) - used only for SELECT operation
-- Abstract complex query into virtual table for easy SELECT
CREATE VIEW MyView AS
SELECT so.OrderID, so.OrderDate, sp.ProductID, sp.Name, sod.Quantity 
FROM shop_product sp, shop_order so, shop_orderDetails sod
WHERE sp.ProductID = sod.ProductID
AND sod.OrderID = so.OrderID



-- Create Stored Procedure (can be used for all Data operations: INSERT, SELECT, UPDATE, DELETE, etc.)
-- Pros: very fast, separation of concerns, security 
-- Cons: Few hosting providers allow it, hard to test, business logic in the DB layer, VCS
DELIMITER //
CREATE PROCEDURE getOrders (IN input_orderID INT)
BEGIN
    SELECT so.OrderID, so.OrderDate, sp.ProductID, sp.Name, sod.Quantity 
    FROM shop_product sp, shop_order so, shop_orderDetails sod
    WHERE sp.ProductID = sod.ProductID
    AND sod.OrderID = so.OrderID
    AND so.OrderID = input_orderID;
END //




-- Create Trigger to adjust product quantities when an order has been placed
DELIMITER //
Create Trigger after_insert_shop_orderDetails AFTER INSERT ON shop_orderDetails FOR EACH ROW
BEGIN
    UPDATE shop_product sp 
    SET sp.Stock = sp.Stock - NEW.Quantity
    WHERE sp.ProductID = NEW.ProductID;
END //


-- Create user and grant access to this specific database 
DROP USER IF EXISTS 'dbuser'@'localhost';
CREATE USER 'dbuser'@'localhost' IDENTIFIED BY '1234'; 
GRANT ALL PRIVILEGES ON ShopDB.* To 'dbuser'@'localhost' IDENTIFIED BY '1234';

-- Save changes
FLUSH PRIVILEGES;