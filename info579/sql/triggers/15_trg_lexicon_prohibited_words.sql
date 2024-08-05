-- Create the trigger to check for prohibited words in the base_form
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_prohibited_words;
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_prohibited_words
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    DECLARE prohibited_word_found INT DEFAULT 0;
    SELECT COUNT(*)
    INTO prohibited_word_found
    FROM stixd_corpus.prohibited_words
    WHERE word = NEW.base_form;

    IF prohibited_word_found > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'base_form contains a prohibited word';
    END IF;
END;
//
DELIMITER ;