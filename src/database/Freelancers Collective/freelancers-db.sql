
--https://vertabelo.com/blog/a-data-model-for-a-freelancers-collective/

DROP DATABASE IF EXISTS freelancers;

CREATE DATABASE freelancers;

USE freelancers;


CREATE TABLE availability
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
availability_name VRACHAR(50) NOT NULL UNIQUE COMMENT('full-time, less than 20 hours a week, etc).'),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE freelancer
(
freelancer_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
username
password
first_name
last_name
email
phone
city
country
current_availability_id
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE skill
(
skill_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
skill_name VRACHAR(50) NOT NULL UNIQUE COMMENT('project management, writing, or design  ...'),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE skill_level
(
skill_level_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
skill_level VRACHAR(50) NOT NULL UNIQUE COMMENT('“basic”, “advanced”, “expert” ...'),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE has_skill
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
freelancer_id INT UNSIGNED NOT NULL,
skill_id INT UNSIGNED NOT NULL,
skill_level_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE customer
(
customer_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
username
password
first_name
last_name
email
phone
city
country
details TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE project
(
project_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
customer_id INT UNSIGNED NOT NULL,
project_name
posted_date
description
budget_plan DECIMAL(10, 2) NOT NULL,
budget_estimate DECIMAL(10, 2) NOT NULL,
budget_actual DECIMAL(10, 2) NOT NULL,
amount_paid DECIMAL(10, 2) NOT NULL,
project_outcome_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE project_outcome
(
outcome_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
outcome_name VARCHAR(100) NOT NULL UNIQUE COMMENT('“negotiation phase”, “project started”, “project paused by client”, “project paused by collective” , “in progress”, “delivered”, “failed”'),
ongoing TINYINT(1) NOT NULL DEFAULT '0',
onhold TINYINT(1) NOT NULL DEFAULT '0',
is_completed_successfully TINYINT(1) NOT NULL DEFAULT '0',
is_completed_successfully TINYINT(1) NOT NULL DEFAULT '0',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE project_status_history
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
project_id INT UNSIGNED NOT NULL,
project_outcome_id INT UNSIGNED NOT NULL,
details TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE skill_required
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
project_id INT UNSIGNED NOT NULL,
skill_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE team
(
team_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
team_name
description
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE team_member
(
team_id INT UNSIGNED NOT NULL,
freelancer_id INT UNSIGNED NOT NULL,
hours_worked INT UNSIGNED DEFAULT '0',
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (team_id, freelancer_id)
);


CREATE TABLE team_project
(
team_id INT UNSIGNED NOT NULL,
project_id INT UNSIGNED NOT NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (team_id, project_id)
);


-- This is where we’ll list all possible phases we could have during any project. We can’t know all the possible phases upfront (though we can assume most of them)
CREATE TABLE phase_catalog
(
phase_catalog_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
phase_catalog_name VARCHAR(100) NOT NULL UNIQUE COMMENT('Some possible project phases are “new project inserted by client”, “project revised”, “proposal sent to client”, “client responded”'),
project_outcome_id INT UNSIGNED,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE phase_plan
(
phase_plan_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
project_id INT UNSIGNED NOT NULL,
phase_catalog_id INT UNSIGNED NOT NULL,
start_time_planned DATETIME NOT NULL,
end_time_planned DATETIME NOT NULL,
freelancer_id INT UNSIGNED NOT NULL COMMENT('Freelancer who inserted this record.'),
comment TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (team_id, project_id)
);


CREATE TABLE in_charge
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
team_id INT UNSIGNED NOT NULL,
phase_plan_id INT UNSIGNED NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (team_id, project_id)
);

CREATE TABLE phase_history
(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
customer_id INT UNSIGNED NOT NULL COMMENT('Customer who inserted this record.'),
freelancer_id INT UNSIGNED NOT NULL COMMENT('Freelancer who inserted this record.'),
project_id INT UNSIGNED NOT NULL,
phase_catalog_id INT UNSIGNED NOT NULL,
start_time_planned DATETIME NOT NULL,
end_time_planned DATETIME NOT NULL,
comments TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);




