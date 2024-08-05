-- Create trigger to ensure gender is not null if word_class starts with noun_ or pn
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_word_class_gender
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_word_class_gender
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    IF (NEW.word_class LIKE 'noun_%' OR NEW.word_class LIKE 'pn%') THEN
        IF (NEW.gender IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'gender must be NOT NULL if word_class starts with "noun_" or "pn"';
        END IF;
    END IF;
END;
//
DELIMITER ;