-- Create the stixd_corpus.lexicon table (create_table_lexicon.sql)
DROP TABLE IF EXISTS stixd_corpus.lexicon;
CREATE TABLE IF NOT EXISTS stixd_corpus.lexicon (
    lex_id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    logical_symbol VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    third_arg VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    word_def TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    synsets JSON,
    tagsets JSON
);
-- SHOW CREATE TABLE stixd_corpus.lexicon;
-- Populating table done from Python script.