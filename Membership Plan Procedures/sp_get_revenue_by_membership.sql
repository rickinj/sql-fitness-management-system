DELIMITER $$

CREATE PROCEDURE `sp_get_revenue_by_membership` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_get_revenue_by_membership' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    SELECT ms.membership_id,
           ms.membership_type,
           COALESCE(SUM(ms.price), 0) AS total_revenue
    FROM tbl_memberships ms
    LEFT JOIN tbl_member_membership mm
        ON mm.membership_id = ms.membership_id
    GROUP BY ms.membership_id, ms.membership_type;
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
