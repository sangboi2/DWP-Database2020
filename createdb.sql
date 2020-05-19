DROP DATABASE IF EXISTS ShoppingDB;
CREATE DATABASE ShoppingDB;
USE ShoppingDB;

CREATE TABLE Category (
    category_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(255)
);
CREATE TABLE Postalcode (
    postalcode_id varchar(20) NOT NULL PRIMARY KEY,
    city varchar(255)
);
CREATE TABLE User (
    user_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(255) NULL,
    admin varchar(255) NULL,
    guest varchar(255) NULL,
    user varchar(255) NULL,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    telephone varchar(20) NULL,
    street varchar(255) NULL,
    postalcode varchar(20) NOT NULL,
    country varchar(255) NULL,
    FOREIGN KEY (Postalcode) REFERENCES Postalcode (postalcode_id)
);
CREATE TABLE Shopping (
    shopping_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product varchar(255) NULL,
    image varchar(255) NULL,
    price varchar(255) NULL,
    description varchar(255) NULL,
    user_id int NOT NULL,
    category_id int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN KEY (category_id) REFERENCES Category (category_id)
);
CREATE TABLE Product (
    product_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NULL,
    image varchar(255) NULL,
    description varchar(255) NULL,
    price varchar(255) NULL,
    qty varchar(255) NOT NULL,
    stock varchar(255) NOT NULL,
    shopping_id int NOT NULL,
    category_id int NOT NULL,
    FOREIGN KEY (shopping_id) REFERENCES Shopping (shopping_id),
    FOREIGN KEY (category_id) REFERENCES Category (category_id)

);
CREATE TABLE `Order` (
    order_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user varchar(255) NULL,
    product varchar(255) NULL,
    qty varchar(255) NULL,
    price varchar(255) NULL,
    date_of_purchase DATE NOT NULL,
    delivery_date DATE NOT NULL,
    user_id int NOT NULL,
    product_id int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN KEY (product_id) REFERENCES Product (product_id)
);