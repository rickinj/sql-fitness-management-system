DELIMITER $$

CREATE PROCEDURE `sp_todays_classes` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_todays_classes' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
    
	SELECT c.class_name, c.description,
		CONCAT(t.first_name, ' ', t.last_name) AS name,
        s.start_time, s.end_time, s.day_of_week
        FROM tbl_trainers t 
			JOIN tbl_classes c
				ON t.trainer_id = c.trainer_id
			JOIN tbl_class_schedule s
				ON s.class_id = c.class_id
		WHERE s.day_of_week = DAYNAME(CURDATE());
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
