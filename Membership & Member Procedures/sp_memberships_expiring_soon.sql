DELIMITER $$

CREATE PROCEDURE `sp_members_with_current_membership` ()
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_members_with_current_membership' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

	SELECT 
		m.member_id,
		m.first_name,
		m.last_name,
		mm.membership_id,
		ms.membership_type,
		ms.price,
		mm.start_date,
		mm.end_date
	FROM tbl_member_membership mm
	JOIN tbl_members m 
		ON mm.member_id = m.member_id
	JOIN tbl_memberships ms 
		ON mm.membership_id = ms.membership_id
	WHERE CURDATE() BETWEEN mm.start_date AND mm.end_date;

END$$

DELIMITER ;
