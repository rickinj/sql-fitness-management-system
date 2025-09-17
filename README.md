# Fitness & Wellness Management System

## 1. Project Overview
The **Fitness & Wellness Management System** is designed to manage members, memberships, trainers, classes, class schedules, and equipment for a fitness center or wellness club.  
The system streamlines the process of:
- Tracking memberships
- Assigning trainers to classes
- Managing class schedules
- Maintaining equipment

---

## 2. Objectives
- Maintain a centralized database for all members and their memberships  
- Track class schedules and trainer assignments  
- Maintain equipment records along with their maintenance history  
- Provide data consistency, referential integrity, and historical tracking of activities  

---

## 3. Functional Requirements

### 3.1 Member Management
- Ability to register new members  
- Store personal information (name, email, phone number, address, date of birth, join date)  

### 3.2 Membership Management
- Define various membership types (e.g., Monthly, Quarterly, Yearly)  
- Store duration and pricing details  
- Assign memberships to members with a defined start and end date  

### 3.3 Trainer Management
- Manage trainer records including contact information and area of specialty  
- Track hire date for administrative purposes  

### 3.4 Class and Schedule Management
- Define available classes and assign trainers to each class  
- Create and manage class schedules (time slots, day of the week)  

### 3.5 Equipment and Maintenance Management
- Store information about fitness equipment (purchase date, maintenance dates)  
- Record all maintenance activities related to each equipment  

---

## 4. Business Rules
- A member can have multiple memberships (e.g., overlapping or renewing)  
- Each class is handled by one trainer, but a trainer can handle multiple classes  
- Class schedules should not overlap for the same trainer  
- Maintenance logs must be entered every time maintenance is done, even if it's minor  
- Equipment's `last_maintenance_date` must be updated after each new maintenance record  
- **⚠️ Memberships must not be assigned retroactively (`start_date ≥ join_date`) — VERY IMPORTANT**  

