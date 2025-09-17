# Entity-Relationship Overview

## Entities & Attributes

### tbl_members
Stores information about members of the fitness center.  
- `member_id`: Unique ID for each member  
- `first_name`, `last_name`: Personal identification  
- `email`, `phone_number`, `address`: Contact details  
- `date_of_birth`: DOB of member  
- `join_date`: Membership start date  

---

### tbl_memberships
Details of available membership plans.  
- `membership_id`: Unique ID for each membership  
- `membership_type`: Type of membership (e.g., Monthly)  
- `description`: Description of benefits  
- `duration_in_months`: Duration of membership  
- `price`: Cost of membership  

---

### tbl_member_membership
Linking table for many-to-many relationship between members and memberships.  
- `member_membership_id`: Unique ID  
- `member_id`: FK to tbl_members  
- `membership_id`: FK to tbl_memberships  
- `start_date`, `end_date`: Validity of the membership  

---

### tbl_trainers
Trainer profiles and qualifications.  
- `trainer_id`: Unique ID  
- `first_name`, `last_name`: Trainer name  
- `email`, `phone_number`: Contact details  
- `specialty`: Trainer's area of expertise  
- `hire_date`: Joining date  

---

### tbl_classes
Details about various fitness classes.  
- `class_id`: Unique ID  
- `class_name`: Name of the class (e.g., Yoga)  
- `description`: Class details  
- `trainer_id`: FK to tbl_trainers  

---

### tbl_class_schedule
Schedule for each class throughout the week.  
- `schedule_id`: Unique ID  
- `class_id`: FK to tbl_classes  
- `start_time`, `end_time`: Timings of the class  
- `day_of_week`: Day class is conducted  

---

### tbl_equipment
Tracks equipment used in the gym.  
- `equipment_id`: Unique ID  
- `equipment_name`: Name of the equipment  
- `description`: Details about equipment  
- `purchase_date`, `last_maintenance_date`: Equipment lifecycle tracking  

---

### tbl_equipment_maintenance
History of maintenance performed on each equipment.  
- `maintenance_id`: Unique ID  
- `equipment_id`: FK to tbl_equipment  
- `maintenance_date`: Date of maintenance  
- `description`: Notes about the maintenance activity  
