-- Create the stixd_corpus.word_tags table in the specified database (create_table_word_tags.sql)
-- DROP TABLE IF EXISTS stixd_corpus.word_tags;
CREATE TABLE IF NOT EXISTS stixd_corpus.word_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    first_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    second_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    third_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
);
-- SHOW CREATE TABLE stixd_corpus.word_tags
-- Populating the table done with SQL seed script.