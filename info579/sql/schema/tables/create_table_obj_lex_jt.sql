-- Create the stixd_corpus.obj_lex_jt table (create_table_obj_lex_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.obj_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.obj_lex_jt (
    obj_id VARCHAR(292),
    lex_id INT,
    PRIMARY KEY (obj_id, lex_id),
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.obj_lex_jt;
-- Populating table done from primary tables.