-- Create a trigger to enforce the mutual exclusivity of preposition and gender (stix_corpus_12.sql)
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_preposition_gender
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_preposition_gender
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    IF (NEW.preposition IS NOT NULL AND NEW.gender IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'preposition and gender cannot both be NOT NULL';
    END IF;
END;
//
DELIMITER ;