DELIMITER $$

CREATE PROCEDURE `sp_get_class_schedule` (
	IN p_class_id INT
)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_get_class_schedule' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
	SELECT 
		c.class_id,
		c.class_name,
		c.description,
		t.trainer_id,
		CONCAT(t.first_name, ' ', t.last_name) AS trainer_name,
		s.day_of_week,
		s.start_time,
		s.end_time
	FROM tbl_class_schedule s
	JOIN tbl_classes c ON s.class_id = c.class_id
	JOIN tbl_trainers t ON c.trainer_id = t.trainer_id
	WHERE c.class_id = p_class_id
	ORDER BY s.day_of_week, s.start_time;
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
