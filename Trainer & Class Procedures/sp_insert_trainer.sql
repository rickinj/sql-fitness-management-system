DELIMITER $$

CREATE PROCEDURE `sp_insert_trainer`(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_specialty VARCHAR(100),
    IN p_hire_date DATE

)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_insert_trainer' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;
    
	INSERT INTO tbl_trainers (
        first_name, 
        last_name, 
        email, 
        phone_number, 
        specialty, 
        hire_date
	)
    VALUES (
        p_first_name, 
        p_last_name, 
        p_email, 
        p_phone_number, 
        p_specialty, 
        p_hire_date
    );
    
    SET v_returncode = 0;
    #SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
