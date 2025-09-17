DELIMITER $$

CREATE TRIGGER trg_update_last_maintenance
AFTER INSERT ON tbl_equipment_maintenance
FOR EACH ROW
BEGIN
    UPDATE tbl_equipment
    SET last_maintenance_date = NEW.maintenance_date
    WHERE equipment_id = NEW.equipment_id;
END$$

DELIMITER ;
