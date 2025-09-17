DELIMITER $$

CREATE EVENT ev_expired_memberships_check
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    INSERT INTO tbl_logs(log_date, log_type, log_message)
    SELECT NOW(), 'Membership Expired', 
           CONCAT('Membership ', m.membership_id, ' for member ', m.member_id, ' expires today')
    FROM tbl_member_membership m
    WHERE m.expiry_date = CURDATE();
END$$

DELIMITER ;
