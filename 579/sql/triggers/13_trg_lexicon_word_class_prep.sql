-- Create trigger to ensure preposition is not null if word_class starts with adj_tr or dv_
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_word_class_preposition
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_word_class_preposition
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    IF (NEW.word_class LIKE 'adj_tr%' OR NEW.word_class LIKE 'dv_%') THEN
        IF (NEW.preposition IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'preposition must be NOT NULL if word_class starts with "adj_tr" or "dv_"';
        END IF;
    END IF;
END;
//
DELIMITER ;