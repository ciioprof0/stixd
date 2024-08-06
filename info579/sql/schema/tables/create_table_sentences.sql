-- Create the stixd_corpus.sentences table
-- DROP TABLE IF EXISTS stixd_corpus.sentences;
CREATE TABLE IF NOT EXISTS stixd_corpus.sentences (
    sent_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_sent TEXT,
    proc_sent JSON
);
-- SHOW CREATE TABLE stixd_corpus.sentences;

-- Populating table done from Python script.