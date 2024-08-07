-- Create the stixd_corpus.prohibited_words table (create_table_prohib_words.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_words;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_words (
    word VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_words;
-- Populating the table done with SQL seed script.
