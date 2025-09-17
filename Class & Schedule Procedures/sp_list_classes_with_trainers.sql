DELIMITER $$

CREATE PROCEDURE `sp_list_classes_with_trainers` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_list_classes_with_trainers' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
	SELECT 
		c.*,
		CONCAT(t.first_name, ' ', t.last_name) AS trainer_name
	FROM tbl_classes c 
	JOIN tbl_trainers t ON c.trainer_id = t.trainer_id;
    
    SET v_returncode = 0;
    #SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
