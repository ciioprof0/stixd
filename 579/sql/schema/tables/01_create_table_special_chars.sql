-- Create the special_characters table in the specified database
DROP TABLE IF EXISTS stixd_corpus.special_characters;
CREATE TABLE stixd_corpus.special_characters (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    spec_char CHAR(1) UNIQUE,
    esc_seq VARCHAR(10)
);
-- SHOW CREATE TABLE stixd_corpus.special_characters;