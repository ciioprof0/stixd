-- Create the stixd_corpus.validation_results table (create_table_validation_results.sql)
-- DROP TABLE IF EXISTS stixd_corpus.validation_results;
CREATE TABLE IF NOT EXISTS stixd_corpus.validation_results (
    val_id INT AUTO_INCREMENT PRIMARY KEY,
    obj_id VARCHAR(292) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    is_valid BOOLEAN,
    val_errors JSON,
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id)
);
-- SHOW CREATE TABLE stixd_corpus.validation_results;
-- Populating table done from Python script.