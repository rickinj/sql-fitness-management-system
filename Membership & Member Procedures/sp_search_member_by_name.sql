DELIMITER $$

CREATE PROCEDURE `sp_search_member_by_name` (
	IN p_first_name VARCHAR(50),
	IN p_last_name VARCHAR(50)
)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_search_member_by_name' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

	SELECT *
	FROM tbl_members 
	WHERE first_name LIKE p_first_name
	OR last_name LIKE p_last_name;

    SET v_returncode = 0;

END$$

DELIMITER ;
