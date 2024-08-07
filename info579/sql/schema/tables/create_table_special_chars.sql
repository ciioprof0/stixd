-- Create the stixd_corpus.special_characters table (create_table_spec_chars.sql)
-- DROP TABLE IF EXISTS stixd_corpus.special_characters;
CREATE TABLE IF NOT EXISTS stixd_corpus.special_characters (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    spec_char CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    esc_seq VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);
-- SHOW CREATE TABLE stixd_corpus.special_characters;
-- Populating the table done with SQL seed script.
