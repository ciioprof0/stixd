-- Create the stixd_corpus.prohibited_intersections table (create_table_prohib_intersections.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_intersections;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_intersections (
    word_tag1 VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    word_tag2 VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY (word_tag1, word_tag2)
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_intersections;
-- Populating the table done with SQL seed script.