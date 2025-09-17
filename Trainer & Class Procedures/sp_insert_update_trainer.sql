DELIMITER $$

CREATE PROCEDURE `sp_insert_update_trainer`(
    IN p_trainer_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_specialty VARCHAR(100),
    IN p_hire_date DATE
)
BEGIN
    DECLARE v_returncode INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        VALUES (-1, @errmsg, 'sp_insert_update_trainer', 'DB', NOW());
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    -- Update if trainer exists
    IF p_trainer_id IS NOT NULL AND EXISTS (SELECT 1 FROM tbl_trainers WHERE trainer_id = p_trainer_id) THEN
        UPDATE tbl_trainers
        SET
            first_name   = p_first_name,
            last_name    = p_last_name,
            email        = p_email,
            phone_number = p_phone_number,
            specialty    = p_specialty,
            hire_date    = p_hire_date
        WHERE trainer_id = p_trainer_id;
    ELSE
        -- Insert new trainer; trainer_id auto-generated
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
    END IF;

    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
