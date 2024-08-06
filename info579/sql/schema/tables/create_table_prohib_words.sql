-- Create the stixd_corpus.prohibited_words table
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_words;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_words (
    word VARCHAR(20) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_words;

-- Populating the table done with SQL seed script.