-- Create the stixd_corpus.doc_lex_jt table (create_table_doc_lex_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.doc_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_lex_jt (
    doc_id INT,
    lex_id INT,
    PRIMARY KEY (doc_id, lex_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_lex_jt;
-- Populating table done from primary tables.