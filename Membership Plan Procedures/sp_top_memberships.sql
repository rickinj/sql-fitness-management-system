DELIMITER $$

CREATE PROCEDURE `sp_top_memberships` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_top_memberships' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    SELECT ms.membership_id,
			ms.membership_type,
           COUNT(*) AS count_per_membership
    FROM tbl_memberships ms
    INNER JOIN tbl_member_membership mm
        ON mm.membership_id = ms.membership_id
    GROUP BY ms.membership_id, ms.membership_type
    ORDER BY count_per_membership DESC;
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
