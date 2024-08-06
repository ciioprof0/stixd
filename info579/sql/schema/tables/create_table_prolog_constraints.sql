-- Create the stixd_corpus.prolog_constraints table
-- DROP TABLE IF EXISTS stixd_corpus.prolog_constraints;
CREATE TABLE IF NOT EXISTS stixd_corpus.prolog_constraints (
    constraint_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(511),
    pattern VARCHAR(255),
    message VARCHAR(255),
    auto_correct BOOLEAN
);
-- SHOW CREATE TABLE stixd_corpus.prolog_constraints;