USE bookstore_db;

-- Create roles
CREATE ROLE manager;
CREATE ROLE clerk;
CREATE ROLE viewer;

-- Grant permissions
GRANT ALL PRIVILEGES ON bookstore_db.* TO manager;
GRANT SELECT, INSERT, UPDATE ON bookstore_db.* TO clerk;
GRANT SELECT ON bookstore_db.* TO viewer;

-- Create users and assign roles
CREATE USER 'book_admin'@'localhost' IDENTIFIED BY 'securePass123';
GRANT manager TO 'book_admin'@'localhost';

CREATE USER 'store_clerk'@'localhost' IDENTIFIED BY 'clerkPass';
GRANT clerk TO 'store_clerk'@'localhost';

CREATE USER 'guest_user'@'localhost' IDENTIFIED BY 'guestPass';
GRANT viewer TO 'guest_user'@'localhost';