
DROP DATABASE IF EXISTS musical_shop;

CREATE DATABASE musical_shop;

USE musical_shop;


CREATE TABLE category
(
category_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE COMMENT('guitar, keyboards, drums, wind instruments, .. '),
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE manufacturer
(
manufacturer_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
country_id INT UNSIGNED NOT NULL, -- should be a country table for normalization
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE instrument
(
instrument_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
instrument_name VARCHAR(100) NOT NULL,
category_id INT UNSIGNED NOT NULL,
manufacturer_id INT UNSIGNED NOT NULL,
description VARCHAR(100) DEFAULT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- for every individual item in the stock
CREATE TABLE inventory
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
instrument_id INT UNSIGNED NOT NULL,
serial_number VRACHAR(50) NOT NULL,
price DECIMAL(10, 2) NOT NULL,
year_of_production YEAR,
description TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



CREATE TABLE user
(
user_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) DEFAULT NULL,
email VARCHAR(50) DEFAULT NULL,
usename VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
notes TEXT DEFAULT NULL,
photo BLOB DEFAULT NULL,
confirmation_code VARCHAR(36) NOT NULL,
confirmation_time DATETIME COMMENT('When the registration/confirmation was completed.'),
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE order_status
(
status_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
status_name VARCHAR(30) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT chk_order_status ( status_name IN ('order placed', 'paid', 'canceled', 'completed', 'sent'))
);

CREATE TABLE order_status_log
(
order_id INT UNSIGNED NOT NULL,
status_id INT UNSIGNED NOT NULL,
date_time DATETIME NOT NULL
);

CREATE TABLE payment
(
payment_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
payment_type ENUM('CASH', 'CREDIT_CARD', 'PAY_PAL') NOT NULL,
amount DECIMAL(10, 2) NOT NULL,
payment_date DATETIME,
trnsaction_id VARCHAR(100),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

CREATE TABLE order
(
order_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
user_id INT UNSIGNED NOT NULL,
total_price DECIMAL(10, 2) NOT NULL,
order_status_id INT UNSIGNED NOT NULL,
time_paid DATETIME,
time_canceled DATETIME,
time_completed DATETIME,
time_sent DATETIME,
time_delivered DATETIME,
payment_id INT UNSIGNED NOT NULL,
delivery_address VARCHAR(255) NOT NULL,
preferred_delivery_time DATETIME,
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE order_iem
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
order_id INT UNSIGNED NOT NULL,
quantity INT UNSIGNED NOT NULL DEFAULT '1',
unit_price DECIMAL(10, 2) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
