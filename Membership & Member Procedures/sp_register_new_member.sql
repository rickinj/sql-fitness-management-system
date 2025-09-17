DELIMITER $$

CREATE PROCEDURE `sp_register_new_member`(
	IN p_first_name VARCHAR(50), 
    IN p_last_name VARCHAR(50), 
    IN p_email VARCHAR(100),  
    IN p_membership_id INT, 
    IN p_start_date DATE
)
BEGIN
	DECLARE v_ErrorText VARCHAR(200) ;
	DECLARE v_returncode INT ;
	DECLARE v_new_member_id INT;
    DECLARE v_duration_months INT;
    DECLARE v_end_date DATE;
       
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN	  
			GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
			ROLLBACK;
			INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
			SELECT -1 AS Status , @p2 AS Message , 'sp_register_new_member' , 'DB', NOW() FROM DUAL;
			SET v_returncode = -1;
            
			SELECT v_returncode as ret_status;
			
		END;	

	START TRANSACTION;  
	
    INSERT INTO tbl_members (first_name, 
							last_name, 
                            email, 
                            join_date) 
	VALUES (p_first_name, 
			p_last_name, 
            p_email, 
            p_start_date
    );
    
	SET v_new_member_id = LAST_INSERT_ID();
    
    SELECT duration_in_months INTO v_duration_months
    FROM tbl_memberships
    WHERE membership_id = p_membership_id;
    
    SET v_end_date = DATE_ADD(p_start_date, INTERVAL v_duration_months MONTH);
	SET v_end_date = DATE_SUB(v_end_date, INTERVAL 1 DAY);
    
    INSERT INTO tbl_member_membership (member_id, 
										membership_id, 
                                        start_date, 
                                        end_date) 
	VALUES (v_new_member_id, 
			p_membership_id, 
            p_start_date, 
            v_end_date
    );

	SET v_returncode = 0;
	COMMIT;
	SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
