DELIMITER $$

CREATE PROCEDURE `sp_get_active_memberships`()
BEGIN
	DECLARE v_ErrorText VARCHAR(200) ;
	DECLARE v_returncode INT ;
	DECLARE v_start_of_year DATE;
	DECLARE v_end_of_year DATE;   
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN	  
			GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
			INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
			SELECT -1 AS Status , @p2 AS Message , 'sp_get_active_memberships' , 'DB', NOW() FROM DUAL;
			SET v_returncode = -1;
			
			SELECT v_returncode as ret_status;
			
		END;	
	
	SET v_start_of_year = STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-01'), '%Y-%m-%d');
	SET v_end_of_year   = STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-12-31'), '%Y-%m-%d');
	
	SELECT 
		m.member_id,
		m.first_name,
		m.last_name,
		mm.membership_id,
		ms.membership_type,
		mm.start_date,
		mm.end_date
	FROM tbl_member_membership mm
	JOIN tbl_members m ON mm.member_id = m.member_id
	JOIN tbl_memberships ms ON mm.membership_id = ms.membership_id
	WHERE mm.start_date >= v_start_of_year
	  AND mm.end_date <= v_end_of_year;
	
	SET v_returncode = 0;
	SELECT v_returncode AS ret_status;
	
END$$

DELIMITER ;
