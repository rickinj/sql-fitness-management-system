CREATE DATABASE fitnees_management_system;

USE fitnees_management_system;

CREATE TABLE tbl_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    join_date DATE
);

CREATE TABLE tbl_memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    membership_type VARCHAR(30),
    description TEXT,
    duration_in_months INT,
    price DECIMAL(10,2)
);

CREATE TABLE tbl_member_membership (
    member_membership_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    membership_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (member_id) REFERENCES tbl_members(member_id),
    FOREIGN KEY (membership_id) REFERENCES tbl_memberships(membership_id)
);

CREATE TABLE tbl_trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    specialty VARCHAR(100),
    hire_date DATE
);

CREATE TABLE tbl_classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50),
    description TEXT,
    trainer_id INT,
    FOREIGN KEY (trainer_id) REFERENCES tbl_trainers(trainer_id)
);

CREATE TABLE tbl_class_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    start_time TIME,
    end_time TIME,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    FOREIGN KEY (class_id) REFERENCES tbl_classes(class_id)
);

CREATE TABLE tbl_equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(100),
    description TEXT,
    purchase_date DATE,
    last_maintenance_date DATE
);

CREATE TABLE tbl_equipment_maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT,
    maintenance_date DATE,
    description TEXT,
    FOREIGN KEY (equipment_id) REFERENCES tbl_equipment(equipment_id)
);

SELECT * FROM tbl_members;

SELECT * FROM tbl_memberships;

SELECT * FROM tbl_trainers;

SELECT * FROM tbl_equipment;

SELECT * FROM tbl_classes;

SELECT * FROM tbl_member_membership;

SELECT * FROM tbl_class_schedule;

SELECT * FROM tbl_equipment_maintenance;

