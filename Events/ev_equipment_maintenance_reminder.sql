DELIMITER $$

CREATE EVENT ev_equipment_maintenance_reminder
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    INSERT INTO tbl_logs(log_date, log_type, log_message)
    SELECT NOW(), 'Maintenance Reminder', 
           CONCAT('Equipment ', e.equipment_id, ' not maintained for 90+ days')
    FROM tbl_equipment e
    WHERE e.last_maintenance_date <= CURDATE() - INTERVAL 90 DAY;
END$$

DELIMITER ;
