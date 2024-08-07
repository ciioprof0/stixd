-- Create the stixd_corpus.sentences table (create_table_sentences.sql)
-- DROP TABLE IF EXISTS stixd_corpus.sentences;
CREATE TABLE IF NOT EXISTS stixd_corpus.sentences (
    sent_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_sent TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    raw_text_hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    proc_sent JSON
);
-- SHOW CREATE TABLE stixd_corpus.sentences;
-- Populating table done from Python script.