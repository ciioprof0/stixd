-- Create the stixd_corpus.word_tags table in the specified database
-- DROP TABLE IF EXISTS stixd_corpus.word_tags;
CREATE TABLE IF NOT EXISTS stixd_corpus.word_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) NOT NULL,
    first_arg VARCHAR(31) NOT NULL,
    second_arg VARCHAR(31) NOT NULL,
    third_arg VARCHAR(31) DEFAULT NULL,
    word_class VARCHAR(31) NOT NULL
);

-- SHOW CREATE TABLE stixd_corpus.word_tags

-- Populating the table done with SQL seed script.