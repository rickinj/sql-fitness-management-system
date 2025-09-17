DELIMITER $$

CREATE PROCEDURE `sp_avg_membership_duration` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_avg_membership_duration' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    SELECT AVG(duration_in_months) AS avg_duration
    FROM tbl_memberships;

END$$

DELIMITER ;
