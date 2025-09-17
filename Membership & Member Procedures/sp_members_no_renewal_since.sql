DELIMITER $$

CREATE PROCEDURE `sp_members_no_renewal_since` (
    IN p_date DATE
)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_members_no_renewal_since' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

        SELECT 
        mm.member_id,
        m.first_name,
        m.last_name,
        MAX(mm.end_date) AS last_membership_end
    FROM tbl_member_membership mm
    JOIN tbl_members m 
        ON mm.member_id = m.member_id
    GROUP BY mm.member_id, m.first_name, m.last_name
    HAVING MAX(mm.end_date) < p_date
    ORDER BY mm.member_id;
    
    SET v_returncode = 0;

END$$

DELIMITER ;
