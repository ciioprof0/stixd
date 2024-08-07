-- Create procedure to check for prolog constraints )
DELIMITER //
CREATE PROCEDURE stixd_corpus.check_prolog_constraints (IN word_form VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE constraint_violation VARCHAR(255);
    DECLARE constraint_message VARCHAR(255);

    DECLARE cur CURSOR FOR SELECT pattern, message FROM stixd_corpus.prolog_constraints;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO constraint_violation, constraint_message;
        IF done THEN
            LEAVE read_loop;
        END IF;
        IF NOT (word_form REGEXP constraint_violation) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = constraint_message;
        END IF;
    END LOOP;

    CLOSE cur;
END;
//
DELIMITER ;