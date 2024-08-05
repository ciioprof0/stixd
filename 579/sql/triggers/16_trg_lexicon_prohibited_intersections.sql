-- Create the trigger to check for prohibited intersections (stix_corpus_17.sql)
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_prohibited_intersections;
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_prohibited_intersections
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    DECLARE class_check INT DEFAULT 0;

    -- Check first condition
    SELECT COUNT(*)
    INTO class_check
    FROM stixd_corpus.prohibited_intersections
    WHERE class1 = NEW.word_class
      AND class2 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = NEW.preposition);

    IF class_check > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This combination of word_class and preposition is prohibited';
    END IF;

    -- Reset the variable
    SET class_check = 0;

    -- Check second condition
    SELECT COUNT(*)
    INTO class_check
    FROM stixd_corpus.prohibited_intersections
    WHERE class2 = NEW.word_class
      AND class1 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = NEW.preposition);

    IF class_check > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This combination of word_class and preposition is prohibited';
    END IF;
END;
//
DELIMITER ;