-- Create master triggers for the lexicon table
DELIMITER //

CREATE TRIGGER stixd_corpus.master_trigger_before_insert
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_form, NEW.word_tag, NEW.third_arg);
END//

CREATE TRIGGER stixd_corpus.master_trigger_before_update
BEFORE UPDATE ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_form, NEW.word_tag, NEW.third_arg);
END//

DELIMITER ;