DELIMITER $$

CREATE TRIGGER trg_prevent_overlapping_schedule
BEFORE INSERT ON tbl_class_schedule
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM tbl_class_schedule s
        JOIN tbl_classes c ON s.class_id = c.class_id
        WHERE c.trainer_id = (SELECT trainer_id FROM tbl_classes WHERE class_id = NEW.class_id)
          AND s.day_of_week = NEW.day_of_week
          AND (
                (NEW.start_time BETWEEN s.start_time AND s.end_time)
             OR (NEW.end_time   BETWEEN s.start_time AND s.end_time)
             OR (s.start_time BETWEEN NEW.start_time AND NEW.end_time)
             OR (s.end_time   BETWEEN NEW.start_time AND NEW.end_time)
              )
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Overlapping schedule for trainer';
    END IF;
END$$

DELIMITER ;
