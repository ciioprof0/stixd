-- Create the trigger to enforce preposition must be from an entry with word_class = prep
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_preposition_check;
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_preposition_check
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    DECLARE word_class_check VARCHAR(31);
    IF (NEW.preposition IS NOT NULL) THEN
        SELECT word_class INTO word_class_check
        FROM stixd_corpus.lexicon
        WHERE lex_id = NEW.preposition;

        IF (word_class_check NOT LIKE 'prep%') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'preposition must reference an entry with word_class starting with "prep"';
        END IF;
    END IF;
END;
//
DELIMITER ;