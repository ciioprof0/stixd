-- Create the stixd_corpus.genders table
-- DROP TABLE IF EXISTS stixd_corpus.genders;
CREATE TABLE IF NOT EXISTS stixd_corpus.genders (
    gender VARCHAR(7) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.genders;

-- Populating the table done with SQL seed script.