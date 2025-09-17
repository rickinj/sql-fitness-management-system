DELIMITER $$

CREATE PROCEDURE `sp_equipment_maintenance_log` (
	IN p_equipment_id INT
)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_equipment_maintenance_log' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
    
	SELECT 
		eq.equipment_id,
		eq.equipment_name,
		m.maintenance_date AS last_maintenance_date,
		m.description
	FROM tbl_equipment eq
	JOIN tbl_equipment_maintenance m 
		ON eq.equipment_id = m.equipment_id
	WHERE eq.equipment_id = p_equipment_id
	ORDER BY m.maintenance_date DESC
	LIMIT 1;
    
    SET v_returncode = 0;
    #SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
