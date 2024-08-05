-- Create the lexicon table in the specified database
DROP TABLE IF EXISTS stixd_corpus.lexicon;
CREATE TABLE stixd_corpus.lexicon (
    lex_id INT AUTO_INCREMENT PRIMARY KEY,
    word_class VARCHAR(31),
    base_form VARCHAR(255),
    logical_symbol VARCHAR(255),
    preposition INT,
    gender VARCHAR(7),
    definition TEXT,
    synsets JSON,
    tagsets JSON,
    UNIQUE (word_class, base_form),
    FOREIGN KEY (preposition) REFERENCES stixd_corpus.lexicon(lex_id),
    FOREIGN KEY (gender) REFERENCES stixd_corpus.genders(gender)
);
SHOW CREATE TABLE stixd_corpus.lexicon;

-- Populating table done from Python script.
