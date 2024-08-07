-- Create the stixd_corpus.prolog_constraints table (create_table_prolog_constraints.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prolog_constraints;
CREATE TABLE IF NOT EXISTS stixd_corpus.prolog_constraints (
    constraint_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(511) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    pattern VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    message VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    auto_correct BOOLEAN
);
-- SHOW CREATE TABLE stixd_corpus.prolog_constraints;
-- Populating the table done with SQL seed script.