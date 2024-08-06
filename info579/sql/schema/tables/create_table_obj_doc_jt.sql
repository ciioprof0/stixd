-- Create the stixd_corpus.obj_doc_jt table
-- DROP TABLE IF EXISTS stixd_corpus.obj_doc_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.obj_doc_jt (
    obj_id VARCHAR(292),
    doc_id INT,
    PRIMARY KEY (obj_id, doc_id),
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id)
);
-- SHOW CREATE TABLE stixd_corpus.obj_doc_jt;