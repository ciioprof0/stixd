-- Create the prohibited_words table in the specified database
DROP TABLE IF EXISTS stixd_corpus.prohibited_words;
CREATE TABLE stixd_corpus.prohibited_words (
    word VARCHAR(20) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_words;