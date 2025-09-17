DELIMITER $$

CREATE PROCEDURE `sp_members_without_active_membership` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_members_without_active_membership' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    SELECT m.*
    FROM tbl_members m
    WHERE NOT EXISTS ( SELECT 1 FROM tbl_member_membership mm
						WHERE m.member_id = mm.member_id
                        AND CURDATE() BETWEEN mm.start_date AND mm.end_date
					);
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
