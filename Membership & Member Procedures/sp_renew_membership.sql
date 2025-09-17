DELIMITER $$

CREATE PROCEDURE `sp_renew_membership` (
    IN p_member_id INT,
    IN p_membership_id INT,
    IN p_start_date DATE
)
BEGIN
    DECLARE v_duration_months INT;
    DECLARE v_end_date DATE;
    DECLARE v_ErrorText VARCHAR(200);
    DECLARE v_returncode INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        INSERT INTO tbl_errorlogtable(errorcode, errormsg, sp_name, error_source, createdate)
        SELECT -1 AS Status , @p2 AS Message , 'sp_renew_membership' , 'DB', NOW() FROM DUAL;
        SET v_returncode = -1;
        SELECT v_returncode AS ret_status;
    END;

    SELECT duration_in_months INTO v_duration_months
    FROM tbl_memberships
    WHERE membership_id = p_membership_id;

    SET v_end_date = DATE_ADD(p_start_date, INTERVAL v_duration_months MONTH);
    SET v_end_date = DATE_SUB(v_end_date, INTERVAL 1 DAY);

    INSERT INTO tbl_member_membership (
        member_id,
        membership_id,
        start_date,
        end_date
    ) VALUES (
        p_member_id,
        p_membership_id,
        p_start_date,
        v_end_date
    );

    SET v_returncode = 0;
    SELECT v_returncode AS ret_status;

END$$

DELIMITER ;
