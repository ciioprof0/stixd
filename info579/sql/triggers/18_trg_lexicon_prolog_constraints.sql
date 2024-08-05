-- Create the trigger to check for prolog constraints
-- DROP TRIGGER IF EXISTS stixd_corpus.trg_lexicon_prolog_constraints;
DELIMITER //
CREATE TRIGGER stixd_corpus.trg_lexicon_prolog_constraints
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    CALL stixd_corpus.check_prolog_constraints(NEW.base_form);
END;
//
DELIMITER ;
