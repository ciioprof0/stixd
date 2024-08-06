-- Create the stixd_corpus.special_characters table
-- DROP TABLE IF EXISTS stixd_corpus.special_characters;
CREATE TABLE IF NOT EXISTS stixd_corpus.special_characters (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    spec_char CHAR(1) UNIQUE,
    esc_seq VARCHAR(10)
);
-- SHOW CREATE TABLE stixd_corpus.special_characters;

-- Populating the table done with SQL seed script.