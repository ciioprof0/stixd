-- Create master triggers for the lexicon table (master_triggers_lexicon.sql)
DELIMITER //

CREATE TRIGGER stixd_corpus.master_trigger_before_insert
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    DECLARE calculated_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

    -- Call the procedure to generate hash
    CALL stixd_corpus.sp_gen_hashes(NEW.word_tag, NEW.word_form, calculated_hash);

    -- Set the hash if it is missing or incorrect
    IF (NEW.tag_form_hash IS NULL OR NEW.tag_form_hash != calculated_hash) THEN
        SET NEW.tag_form_hash = calculated_hash;
    END IF;

    -- Call the procedure to check lexicon constraints
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_tag, NEW.word_form, NEW.logical_symbol, NEW.third_arg);
END;
//

CREATE TRIGGER stixd_corpus.master_trigger_before_update
BEFORE UPDATE ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    DECLARE calculated_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

    -- Call the procedure to generate hash
    CALL stixd_corpus.sp_gen_hashes(NEW.word_tag, NEW.word_form, calculated_hash);

    -- Validate and update the hash
    IF (NEW.tag_form_hash IS NULL OR NEW.tag_form_hash != calculated_hash) THEN
        SET NEW.tag_form_hash = calculated_hash;
    END IF;

    -- Call the procedure to check lexicon constraints
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_tag, NEW.word_form, NEW.logical_symbol, NEW.third_arg);
END;
//
DELIMITER ;
