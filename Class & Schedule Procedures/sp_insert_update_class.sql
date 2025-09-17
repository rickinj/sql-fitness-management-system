DELIMITER $$

CREATE PROCEDURE `sp_insert_update_class`(
    IN p_class_id INT,
    IN p_class_name VARCHAR(50),
    IN p_description TEXT,
    IN p_trainer_id INT
)
BEGIN
    DECLARE v_returncode INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errmsg = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        VALUES (-1, @errmsg, 'sp_insert_update_class', 'DB', NOW());
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    -- Update if class exists
    IF p_class_id IS NOT NULL AND EXISTS (SELECT 1 FROM tbl_classes WHERE class_id = p_class_id) THEN
        UPDATE tbl_classes
        SET
            class_name  = p_class_name,
            description = p_description,
            trainer_id  = p_trainer_id
        WHERE class_id = p_class_id;
    ELSE
        -- Insert new class; class_id auto-generated
        INSERT INTO tbl_classes (
            class_name,
            description,
            trainer_id
        )
        VALUES (
            p_class_name,
            p_description,
            p_trainer_id
        );
    END IF;

    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
