-- Create the stixd_corpus.genders table (create_table_genders.sql)
-- DROP TABLE IF EXISTS stixd_corpus.genders;
CREATE TABLE IF NOT EXISTS stixd_corpus.genders (
    gender VARCHAR(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.genders;
-- Populating the table done with SQL seed script.
