DROP DATABASE IF EXISTS ShoppingDB;
CREATE DATABASE ShoppingDB;
USE ShoppingDB;

CREATE TABLE Category (
    category_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(50)
);
CREATE TABLE Postalcode (
    postalcode_id varchar(20) NOT NULL PRIMARY KEY,
    city varchar(50)
);
CREATE TABLE User (
    user_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(50) NULL,
    admin varchar(50) NULL,
    guest varchar(50) NULL,
    user varchar(50) NULL,
    email varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    telephone varchar(20) NULL,
    street varchar(50) NULL,
    postalcode varchar(20) NOT NULL,
    country varchar(50) NULL,
    FOREIGN KEY (Postalcode) REFERENCES Postalcode (postalcode_id)
);
CREATE TABLE Shopping (
    shopping_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product varchar(50) NULL,
    image varchar(255) NULL,
    price int NOT NULL,
    description varchar(255) NULL,
    user_id int NOT NULL,
    category_id int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN KEY (category_id) REFERENCES Category (category_id)
);
CREATE TABLE Product (
    product_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NULL,
    image varchar(50) NULL,
    description varchar(255) NULL,
    price varchar(255) NULL,
    qty int NOT NULL,
    stock varchar(50) NOT NULL,
    shopping_id int NOT NULL,
    category_id int NOT NULL,
    FOREIGN KEY (shopping_id) REFERENCES Shopping (shopping_id),
    FOREIGN KEY (category_id) REFERENCES Category (category_id)

);
CREATE TABLE `Order` (
    order_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user varchar(50) NULL,
    product varchar(50) NULL,
    qty int NOT NULL,
    price float NOT NULL,
    date_of_purchase DATE NOT NULL,
    delivery_date DATE NOT NULL,
    user_id int NOT NULL,
    product_id int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN KEY (product_id) REFERENCES Product (product_id)
);