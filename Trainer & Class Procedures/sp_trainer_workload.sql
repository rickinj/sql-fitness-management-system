DELIMITER $$

CREATE PROCEDURE `sp_trainer_workload`()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_trainer_workload' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
    
	SELECT 
		t.trainer_id,
		CONCAT(t.first_name, ' ', t.last_name) AS trainer_name,
		COUNT(DISTINCT c.class_id) AS total_classes,
		COUNT(DISTINCT s.schedule_id) AS total_schedules
	FROM tbl_trainers t
	LEFT JOIN tbl_classes c 
		ON t.trainer_id = c.trainer_id
	LEFT JOIN tbl_class_schedule s 
		ON c.class_id = s.class_id
	GROUP BY t.trainer_id, t.first_name, t.last_name;
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
