-- Create procedure to generate and return hash (sp_gen_hashes.sql)
DELIMITER //

CREATE PROCEDURE stixd_corpus.sp_gen_hashes(
    IN new_word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    OUT tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    -- Generate the SHA256 hash for word_tag and word_form combination
    SET tag_form_hash = SHA2(CONCAT(new_word_tag, new_word_form), 256);
END;
//
DELIMITER ;