-- Create the stixd_corpus.documents table
-- DROP TABLE IF EXISTS stixd_corpus.documents;
CREATE TABLE IF NOT EXISTS stixd_corpus.documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_text LONGTEXT,
    raw_text_hash CHAR(64) UNIQUE,
    proc_text JSON,
    metadata JSON
);
-- SHOW CREATE TABLE stixd_corpus.documents;

-- Populating table done from Python script.