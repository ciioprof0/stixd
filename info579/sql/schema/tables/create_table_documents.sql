-- Create the stixd_corpus.documents table (create_table_documents.sql)
-- DROP TABLE IF EXISTS stixd_corpus.documents;
CREATE TABLE IF NOT EXISTS stixd_corpus.documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    raw_text_hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    proc_text JSON,
    metadata JSON
);
-- SHOW CREATE TABLE stixd_corpus.documents;
-- Populating table done from Python script.