
DROP DATABASE IF EXISTS my_cinema;

CREATE DATABASE IF NOT EXISTS my_cinema;

USE my_cinema;

-- other entities like
actor
actor_movie
staff (employee)


CREATE TABLE movie
(
movie_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
length_in_minutes INT UNSIGNED NOT NULL,
year YEAR DEFAULT NULL,
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE auditorium
(
auditorium_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
code CHAR(5) NOT NULL,
floor TINYINT DEFAULT NULL,
description TEXT DEFAULT NULL,
num_of_seats INT UNSIGNED NOT NULL,
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE seat_type
(
seat_type_id TINYINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
type VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT chk_seat_type CHECK (type IN ('REGULAR', 'PREMIUM'))
)


CREATE TABLE seat
(
seat_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
seat_code CHAR(5) NOT NULL,
seat_row SMALLINT UNSIGNED NOT NULL,
seat_number SMALLINT UNSIGNED NOT NULL,
seat_type_id TINYINT UNSIGNED NOT NULL,
auditorium_id INT UNSIGNED NOT NULL,
active TINYINT(1) NOT NULL DEFAULT '1',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_seat_auditorium FOREIGN KEY (auditorium_id) REFERENCES auditorium(auditorium_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_seat_seat_type FOREIGN KEY (seat_type_id) REFERENCES seat_type(seat_type_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE screening  -- event
(
screening_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
movie_id INT UNSIGNED NOT NULL,
auditorium_id INT UNSIGNED NOT NULL,
screening_recurring_type ENUM('NONE', 'DAILY', 'WEEKLY', 'MONTHLY') NOT NULL,
week_day ENUM('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN') NOT NULL,
start_from TIME NOT NULL,
estimated_end_time TIME,
price DECIMAL(10, 2) NOT NULL,
effective_from DATETIME NOT NULL,
valid_untill DATETIME NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
UNIQUE INDEX unique_screening_auditorium(auditorium_id,screening_start),
CONSTRAINT fk_screening_movie FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_screening_auditorium FOREIGN KEY (auditorium_id) REFERENCES auditorium(auditorium_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Add trigger (insert and update) on the above table "screening" to update the estimated_end_time according to ethe movie duration
-- this trigger should check on uniqueness of screening auditorium_id, week_day

CREATE TABLE screening_price
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
screening_id INT UNSIGNED NOT NULL,
seat_type_id INT UNSIGNED NOT NULL,
price DECIMAL(10, 2) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_screening_price_screening FOREIGN KEY (screening_id) REFERENCES screening(screening_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_screening_price_seat_type FOREIGN KEY (seat_type_id) REFERENCES seat_type(seat_type_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE reservation
(
reservation_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
screening_id INT UNSIGNED NOT NULL,
reservation_type ENUM('BY_PHONE', 'ONLINE', 'IN_LOCATION_COUNTER', 'IN_LOCATION_DEVICE')
price DECIMAL(10, 2) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_reservation_screening FOREIGN KEY (screening_id) REFERENCES screening(screening_id) ON DELETE RESTRICT ON UPDATE CASCADE
);



CREATE TABLE reservation_seat
(
reservation_id INT UNSIGNED NOT NULL,
screening_id INT UNSIGNED NOT NULL,
seat_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(screening_id, seat_id),
CONSTRAINT fk_reservation_seat_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_reservation_seat_seat FOREIGN KEY (seat_id) REFERENCES seat(seat_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


