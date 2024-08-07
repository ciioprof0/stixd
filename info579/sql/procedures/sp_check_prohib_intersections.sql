-- Create procedure to check for prohibited word_word_tag intersections  (sp_check_prohib_intersections.sql)
DELIMITER //

CREATE PROCEDURE stixd_corpus.sp_check_prohib_intersections(
    IN new_word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE tag_check INT DEFAULT 0;

    -- Check if the new_word_form exists in the lexicon table
    IF EXISTS (SELECT 1 FROM stixd_corpus.lexicon WHERE word_form = new_word_form) THEN
        -- Check first condition
        SELECT COUNT(*)
        INTO tag_check
        FROM stixd_corpus.prohibited_intersections
        WHERE word_tag1 = new_word_tag
          AND word_tag2 IN (SELECT word_tag
                         FROM stixd_corpus.lexicon
                         WHERE word_form = new_word_form);

        IF tag_check > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This combination of word_tags is prohibited';
        END IF;

        -- Reset the variable
        SET tag_check = 0;

        -- Check second condition
        SELECT COUNT(*)
        INTO tag_check
        FROM stixd_corpus.prohibited_intersections
        WHERE word_tag2 = new_word_tag
          AND word_tag1 IN (SELECT word_tag
                         FROM stixd_corpus.lexicon
                         WHERE word_form = new_word_form);

        IF tag_check > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This combination of word_tags is prohibited';
        END IF;
    END IF;
END;
//
DELIMITER ;