-- Create procedure to check for prohibited word_class intersections of word_class and preposition (sp_check_prohib_intersections.sql)
DELIMITER //

CREATE PROCEDURE stixd_corpus.sp_check_prohib_intersections(
    IN new_word_tag VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE class_check INT DEFAULT 0;

    -- Get the word_class and preposition from the lexicon table
    DECLARE new_word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_preposition INT;

    SELECT word_class INTO new_word_class FROM stixd_corpus.word_tags WHERE word_tag = new_word_tag;
    SELECT preposition INTO new_preposition FROM stixd_corpus.lexicon WHERE word_form = new_word_form;

    -- Check first condition
    SELECT COUNT(*)
    INTO class_check
    FROM stixd_corpus.prohibited_intersections
    WHERE class1 = new_word_class
      AND class2 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = new_preposition);

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
    WHERE class2 = new_word_class
      AND class1 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = new_preposition);

    IF class_check > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This combination of word_class and preposition is prohibited';
    END IF;
END;
//
DELIMITER ;