-- creating tables
--  book:book_author: author book_language: publisher 
--  Customer
--  customer_address address_status address country
--  cust_order order_line: shipping_method: 
--  order_history  order_status
CREATE DATABASE bookshop;

USE bookshop;

CREATE TABLE book (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    publisher_id INT NOT NULL,
    language_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    publication_date DATE NOT NULL,
    PRIMARY KEY (book_id)
);

CREATE TABLE author (
    author_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    PRIMARY KEY (author_id)
);

CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE book_language (
    language_id INT NOT NULL AUTO_INCREMENT,
    language_code CHAR(2) NOT NULL,
    language_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (language_id)
);

CREATE TABLE publisher (
    publisher_id INT NOT NULL AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_info VARCHAR(255),
    PRIMARY KEY (publisher_id)
);

ALTER TABLE book
    ADD FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    ADD FOREIGN KEY (language_id) REFERENCES book_language(language_id);

CREATE TABLE country (
    country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE address (
    address_id INT NOT NULL AUTO_INCREMENT,
    street_number VARCHAR(10) NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    status_id INT NOT NULL AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (status_id)
);

CREATE TABLE customer (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    PRIMARY KEY (customer_id)
);

CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE shipping_method (
    method_id INT NOT NULL AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    estimated_days INT NOT NULL,
    PRIMARY KEY (method_id)
);

CREATE TABLE order_status (
    status_id INT NOT NULL AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (status_id)
);

CREATE TABLE cust_order (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    shipping_method_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id)
);

CREATE TABLE order_line (
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL,
    notes TEXT,
    PRIMARY KEY (history_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Insert common book languages
INSERT INTO book_language (language_code, language_name) VALUES
('EN', 'English'),
('ES', 'Spanish'),
('FR', 'French'),
('DE', 'German'),
('ZH', 'Chinese'),
('JA', 'Japanese'),
('IT', 'Italian'),
('PT', 'Portuguese'),
('RU', 'Russian'),
('AR', 'Arabic');

-- Insert countries
INSERT INTO country (country_name, country_code) VALUES
('United States', 'US'),
('United Kingdom', 'GB'),
('Canada', 'CA'),
('Australia', 'AU'),
('Germany', 'DE'),
('France', 'FR'),
('Spain', 'ES'),
('Italy', 'IT'),
('Japan', 'JP'),
('China', 'CN');

-- Insert address statuses
INSERT INTO address_status (status_name) VALUES
('Active'),
('Previous'),
('Temporary'),
('Shipping'),
('Billing');

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost, estimated_days) VALUES
('Standard Shipping', 4.99, 5),
('Express Shipping', 9.99, 2),
('Next Day Delivery', 19.99, 1),
('International Standard', 14.99, 10),
('International Express', 24.99, 5);

-- Insert order statuses
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned');

-- Insert publishers
INSERT INTO publisher (publisher_name, address, contact_info) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019', 'contact@penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY 10007', 'contact@harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', 'contact@simonschuster.com'),
('Macmillan Publishers', '120 Broadway, New York, NY 10271', 'contact@macmillan.com'),
('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104', 'contact@hachette.com');

-- Insert authors
INSERT INTO author (first_name, last_name, biography) VALUES
('Stephen', 'King', 'Stephen King is an American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels.'),
('J.K.', 'Rowling', 'J.K. Rowling is a British author best known for writing the Harry Potter fantasy series.'),
('George R.R.', 'Martin', 'George R.R. Martin is an American novelist best known for his epic fantasy series A Song of Ice and Fire.'),
('Dan', 'Brown', 'Dan Brown is an American author best known for his thriller novels.'),
('Michelle', 'Obama', 'Michelle Obama is an American attorney and author who served as the First Lady of the United States.'),
('Haruki', 'Murakami', 'Haruki Murakami is a Japanese writer. His novels, essays, and short stories have been bestsellers.'),
('Jane', 'Austen', 'Jane Austen was an English novelist known primarily for her six major novels.'),
('Ernest', 'Hemingway', 'Ernest Hemingway was an American novelist and short story writer.');

-- Insert books
INSERT INTO book (title, publisher_id, language_id, price, stock, publication_date) VALUES
('The Shining', 1, 1, 19.99, 50, '1977-01-28'),
('Harry Potter and the Philosopher\'s Stone', 2, 1, 24.99, 100, '1997-06-26'),
('A Game of Thrones', 3, 1, 29.99, 75, '1996-08-01'),
('The Da Vinci Code', 1, 1, 14.99, 60, '2003-03-18'),
('Becoming', 4, 1, 32.99, 85, '2018-11-13'),
('Norwegian Wood', 5, 5, 21.99, 40, '1987-09-04'),
('Pride and Prejudice', 2, 1, 12.99, 55, '1813-01-28'),
('The Old Man and the Sea', 3, 1, 15.99, 45, '1952-09-01');

-- Link books with authors
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), -- The Shining - Stephen King
(2, 2), -- Harry Potter - J.K. Rowling
(3, 3), -- A Game of Thrones - George R.R. Martin
(4, 4), -- The Da Vinci Code - Dan Brown
(5, 5), -- Becoming - Michelle Obama
(6, 6), -- Norwegian Wood - Haruki Murakami
(7, 7), -- Pride and Prejudice - Jane Austen
(8, 8); -- The Old Man and the Sea - Ernest Hemingway

-- Insert customer data
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101'),
('Emma', 'Johnson', 'emma.j@email.com', '555-0102'),
('Michael', 'Williams', 'michael.w@email.com', '555-0103'),
('Sarah', 'Brown', 'sarah.b@email.com', '555-0104'),
('David', 'Jones', 'david.j@email.com', '555-0105');

-- Insert addresses
INSERT INTO address (street_number, street_name, city, state, postal_code, country_id) VALUES
('123', 'Main St', 'New York', 'NY', '10001', 1),
('456', 'Park Ave', 'Los Angeles', 'CA', '90001', 1),
('789', 'Queen St', 'Toronto', 'ON', 'M5H 2N2', 3),
('321', 'Oxford St', 'London', NULL, 'W1D 2DW', 2),
('654', 'Collins St', 'Melbourne', 'VIC', '3000', 4);

-- Link customers with addresses
INSERT INTO customer_address (customer_id, address_id, status_id, is_default) VALUES
(1, 1, 1, TRUE),  -- John Smith's active address
(2, 2, 1, TRUE),  -- Emma Johnson's active address
(3, 3, 1, TRUE),  -- Michael Williams' active address
(4, 4, 1, TRUE),  -- Sarah Brown's active address
(5, 5, 1, TRUE);  -- David Jones' active address

-- Insert customer orders
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, shipping_address_id, order_total) VALUES
(1, '2023-01-15 10:30:00', 1, 1, 44.98),
(2, '2023-02-01 14:45:00', 2, 2, 54.98),
(3, '2023-03-10 09:15:00', 3, 3, 89.97),
(4, '2023-04-05 16:20:00', 4, 4, 34.98),
(5, '2023-05-20 11:00:00', 1, 5, 65.98);

-- Insert order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 19.99),  -- John ordered 2 copies of The Shining
(2, 2, 2, 24.99),  -- Emma ordered 2 copies of Harry Potter
(3, 3, 3, 29.99),  -- Michael ordered 3 copies of Game of Thrones
(4, 7, 2, 12.99),  -- Sarah ordered 2 copies of Pride and Prejudice
(5, 5, 2, 32.99);  -- David ordered 2 copies of Becoming

-- Insert order history
INSERT INTO order_history (order_id, status_id, status_date, notes) VALUES
(1, 1, '2023-01-15 10:30:00', 'Order placed'),
(1, 2, '2023-01-16 09:00:00', 'Payment confirmed'),
(1, 3, '2023-01-17 14:00:00', 'Order shipped'),
(1, 4, '2023-01-20 11:30:00', 'Order delivered'),
(2, 1, '2023-02-01 14:45:00', 'Order placed'),
(2, 2, '2023-02-02 10:00:00', 'Payment confirmed'),
(2, 3, '2023-02-03 16:00:00', 'Order shipped'),
(2, 4, '2023-02-05 12:30:00', 'Order delivered'),
(3, 1, '2023-03-10 09:15:00', 'Order placed'),
(3, 2, '2023-03-11 11:00:00', 'Payment confirmed'),
(3, 5, '2023-03-12 09:30:00', 'Order cancelled by customer'),
(4, 1, '2023-04-05 16:20:00', 'Order placed'),
(4, 2, '2023-04-06 10:00:00', 'Payment confirmed'),
(4, 3, '2023-04-07 14:00:00', 'Order shipped'),
(4, 4, '2023-04-10 11:30:00', 'Order delivered'),
(5, 1, '2023-05-20 11:00:00', 'Order placed'),
(5, 2, '2023-05-21 09:00:00', 'Payment confirmed'),
(5, 3, '2023-05-22 15:00:00', 'Order shipped'),
(5, 4, '2023-05-25 12:30:00', 'Order delivered');

select * from customer;
show tables;

USE bookshop;

-- Create roles
CREATE ROLE manager;
CREATE ROLE clerk;
CREATE ROLE viewer;

-- Grant permissions
GRANT ALL PRIVILEGES ON bookshop.* TO manager;
GRANT SELECT, INSERT, UPDATE ON bookshop.* TO clerk;
GRANT SELECT ON bookshop.* TO viewer;

-- Create users and assign roles
CREATE USER 'book_admin'@'localhost' IDENTIFIED BY 'securePass123';
GRANT manager TO 'book_admin'@'localhost';

CREATE USER 'store_clerk'@'localhost' IDENTIFIED BY 'clerkPass';
GRANT clerk TO 'store_clerk'@'localhost';

CREATE USER 'guest_user'@'localhost' IDENTIFIED BY 'guestPass';
GRANT viewer TO 'guest_user'@'localhost';