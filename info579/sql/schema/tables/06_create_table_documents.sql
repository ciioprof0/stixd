-- Create the documents table in the specified database
DROP TABLE IF EXISTS stixd_corpus.documents;
CREATE TABLE stixd_corpus.documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_text LONGTEXT,
    proc_text JSON,
    metadata JSON
);
SHOW CREATE TABLE stixd_corpus.documents;

-- Populating table done from Python script.