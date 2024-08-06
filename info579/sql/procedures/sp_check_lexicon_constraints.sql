-- Create procedure to check for prolog constraints
DELIMITER //
CREATE PROCEDURE stixd_corpus.check_prolog_constraints(IN base_form VARCHAR(255))
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
        IF NOT (base_form REGEXP constraint_violation) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = constraint_message;
        END IF;
    END LOOP;

    CLOSE cur;
END;
//
DELIMITER ;

-- Create main procedure to check lexicon constraints
DELIMITER //
CREATE PROCEDURE stixd_corpus.sp_check_lexicon_constraints(
    IN new_base_form VARCHAR(255),
    IN new_word_class VARCHAR(31),
    IN new_preposition INT,
    IN new_gender VARCHAR(7)
)
BEGIN
    -- Step 1: Check prolog constraints
    CALL stixd_corpus.check_prolog_constraints(new_base_form);

    -- Step 2: Check prohibited words
    DECLARE prohibited_word_found INT DEFAULT 0;
    SELECT COUNT(*)
    INTO prohibited_word_found
    FROM stixd_corpus.prohibited_words
    WHERE word = new_base_form;

    IF prohibited_word_found > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'base_form contains a prohibited word';
    END IF;

    -- Step 3: Check prohibited intersections
    CALL stixd_corpus.check_prohib_intersections(new_base_form);

    -- Step 4: Ensure preposition is not null if word_class starts with adj_tr or dv_
    IF (new_word_class LIKE 'adj_tr%' OR new_word_class LIKE 'dv_%') THEN
        IF (new_preposition IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'preposition must be NOT NULL if word_class starts with "adj_tr" or "dv_"';
        END IF;
    END IF;

    -- Step 5: Ensure gender is not null if word_class starts with noun_ or pn
    IF (new_word_class LIKE 'noun_%' OR new_word_class LIKE 'pn%') THEN
        IF (new_gender IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'gender must be NOT NULL if word_class starts with "noun_" or "pn"';
        END IF;
    END IF;

    -- Step 6: Enforce the mutual exclusivity of preposition and gender
    IF (new_preposition IS NOT NULL AND new_gender IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'preposition and gender cannot both be NOT NULL';
    END IF;
END//
//
DELIMITER ;
