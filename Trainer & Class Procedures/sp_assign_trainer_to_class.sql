DELIMITER $$

CREATE PROCEDURE `sp_assign_trainer_to_class` (
    IN p_class_id INT,
    IN p_trainer_id INT
)
BEGIN
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_assign_trainer_to_class' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    UPDATE tbl_classes
    SET trainer_id = p_trainer_id
    WHERE class_id = p_class_id;
    
    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
