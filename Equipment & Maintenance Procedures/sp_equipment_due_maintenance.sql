DELIMITER $$

CREATE PROCEDURE `sp_equipment_due_maintenance` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_equipment_due_maintenance' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
    
	SELECT * FROM tbl_equipment
	WHERE DATE_FORMAT(last_maintenance_date, '%Y-%m') <> DATE_FORMAT(CURDATE(), '%Y-%m');
    
    SET v_returncode = 0;
    #SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
