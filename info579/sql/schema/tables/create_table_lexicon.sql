-- Create the stixd_corpus.lexicon table
DROP TABLE IF EXISTS stixd_corpus.lexicon;
CREATE TABLE IF NOT EXISTS stixd_corpus.lexicon (
    lex_id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12),
    word_form VARCHAR(99),
    logical_symbol VARCHAR(99),
    third_arg VARCHAR(15),
    tag_form_hash VARCHAR(64) UNIQUE,
    word_def TEXT,
    synsets JSON,
    tagsets JSON
);
-- SHOW CREATE TABLE stixd_corpus.lexicon;

-- Populating table done from Python script.
