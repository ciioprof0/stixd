-- Create main procedure to check lexicon constraints (sp_check_lexicon_constraints.sql)
DELIMITER //
CREATE PROCEDURE stixd_corpus.sp_check_lexicon_constraints(
    IN new_word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_logical_symbol VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_third_arg VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE prohibited_word_found INT DEFAULT 0;
    DECLARE tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_preposition INT DEFAULT NULL;

    -- Step 1: Check prolog constraints for word_form
    CALL stixd_corpus.sp_check_prolog_constraints(new_word_form);

    -- Step 2: Check prohibited words
    SELECT COUNT(*)
    INTO prohibited_word_found
    FROM stixd_corpus.prohibited_words
    WHERE word = new_word_form;

    IF prohibited_word_found > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'word_form contains a prohibited word';
    END IF;

    -- Step 3: Check prohibited intersections for word_form
    CALL stixd_corpus.sp_check_prohib_intersections(new_word_tag, new_word_form);

    -- Step 4: Generate and validate hashes
    CALL stixd_corpus.sp_gen_hashes(new_word_tag, new_word_form, tag_form_hash);

    -- Step 5: Check if the tag_form_hash already exists in the lexicon table
    IF EXISTS (SELECT 1 FROM stixd_corpus.lexicon WHERE tag_form_hash = tag_form_hash) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The combination of word_tag and word_form already exists in the lexicon table';
    END IF;

    -- Step 6: Ensure logical_symbol is not null if word_tag starts with adj_tr or dv_
    IF (new_word_tag LIKE 'adj_tr%' OR new_word_tag LIKE 'dv_%') THEN
        IF (new_logical_symbol IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'logical_symbol must be NOT NULL if word_tag starts with "adj_tr" or "dv_"';
        END IF;
    END IF;

    -- Step 7: Ensure third_arg is not null if word_tag starts with noun_ or pn
    IF (new_word_tag LIKE 'noun_%' OR new_word_tag LIKE 'pn%') THEN
        IF (new_third_arg IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'third_arg must be NOT NULL if word_tag starts with "noun_" or "pn"';
        END IF;
    END IF;

    -- Step 8: Enforce the mutual exclusivity of logical_symbol and third_arg
    IF (new_logical_symbol IS NOT NULL AND new_third_arg IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'logical_symbol and third_arg cannot both be NOT NULL';
    END IF;
END //
//
DELIMITER ;