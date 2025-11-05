-- Create database
CREATE DATABASE fitness_management_system;  -- fixed typo "fitnees"
USE fitness_management_system;

-- =========================
-- 1. Members Table
-- =========================
CREATE TABLE tbl_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    join_date DATE NOT NULL,
    CHECK (join_date >= date_of_birth) -- sanity check
);

-- =========================
-- 2. Membership Plans Table
-- =========================
CREATE TABLE tbl_memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    membership_type VARCHAR(30) NOT NULL,
    description TEXT,
    duration_in_months INT NOT NULL CHECK (duration_in_months > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

-- =========================
-- 3. Member-Membership Linking Table
-- Many-to-Many relationship
-- =========================
CREATE TABLE tbl_member_membership (
    member_membership_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    membership_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (member_id) REFERENCES tbl_members(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (membership_id) REFERENCES tbl_memberships(membership_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (end_date >= start_date),
    CHECK (start_date >= (SELECT join_date FROM tbl_members WHERE tbl_members.member_id = member_id)) -- VERY IMPORTANT Business Rule
);

-- =========================
-- 4. Trainers Table
-- =========================
CREATE TABLE tbl_trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    specialty VARCHAR(100),
    hire_date DATE NOT NULL
);

-- =========================
-- 5. Classes Table
-- =========================
CREATE TABLE tbl_classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    description TEXT,
    trainer_id INT NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES tbl_trainers(trainer_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =========================
-- 6. Class Schedule Table
-- =========================
CREATE TABLE tbl_class_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    FOREIGN KEY (class_id) REFERENCES tbl_classes(class_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (end_time > start_time) -- prevent invalid schedules
);

-- =========================
-- 7. Equipment Table
-- =========================
CREATE TABLE tbl_equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(100) NOT NULL,
    description TEXT,
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE
);

-- =========================
-- 8. Equipment Maintenance Table
-- =========================
CREATE TABLE tbl_equipment_maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    description TEXT,
    FOREIGN KEY (equipment_id) REFERENCES tbl_equipment(equipment_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (maintenance_date >= (SELECT purchase_date FROM tbl_equipment WHERE tbl_equipment.equipment_id = equipment_id)) -- logical check
);

-- =========================
-- Sample Selects
-- =========================
SELECT * FROM tbl_members;
SELECT * FROM tbl_memberships;
SELECT * FROM tbl_trainers;
SELECT * FROM tbl_equipment;
SELECT * FROM tbl_classes;
SELECT * FROM tbl_member_membership;
SELECT * FROM tbl_class_schedule;
SELECT * FROM tbl_equipment_maintenance;
