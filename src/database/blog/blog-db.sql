DROP DATABASE IF EXISTS my_blog;

CREATE DATABASE IF NOT EXISTS my_blog;

USE my_blog;

CREATE TABLE user
(
user_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) DEFAULT NULL,
address_id INT UNSIGNED DEFAULT NULL,   -- address table FK
email VARCHAR(50) DEFAULT NULL,
usename VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
phone VRACHAR(20) NOT NULL,
notes TEXT DEFAULT NULL,
photo BLOB DEFAULT NULL,
photo LONGBLOB DEFAULT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE category
(
category_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VRACHAR(50) NOT NULL,
parent_category_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- registered at
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE post
(
post_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
post_code VARCHAR(50) NOT NULL UNIQUE, -- used in blog publishing (title-<random 10 digits number>)
user_id INT UNSIGNED NOT NULL,    -- FK
parent_post_id INT UNSIGNED NOT NULL,  -- FK  (used to group set of posts on the same series)
post_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
title VARCHAR(100) NOT NULL,
sub_title VARCHAR(100) NOT NULL,
content TEXT NOT NULL,
published TINYINT(1) NOT NULL DEFAULT '0',
preview_image LONGBLOB,
published_on DATETIME DATETIME DEFAULT NULL,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

CREATE TABLE post_category
(
category_id INT UNSIGNED NOT NULL,
post_id INT UNSIGNED NOT NULL
);


CREATE TABLE tag
(
tag_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL UNIQUE,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE tag
(
post_id INT UNSIGNED NOT NULL,
tag_id INT UNSIGNED NOT NULL,
added_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (post_id, tag_id)
);

CREATE TABLE comment
(
comment_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
user_id INT UNSIGNED NOT NULL,
post_id INT UNSIGNED NOT NULL,
parent_comment_id INT UNSIGNED DEFAULT NULL,
title VARCHAR(100) NOT NULL,
content TEXT NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);