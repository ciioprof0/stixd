-- Create the stixd_corpus.prohibited_intersections table
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_intersections;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_intersections (
    class1 VARCHAR(31),
    class2 VARCHAR(31),
    PRIMARY KEY (class1, class2)
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_intersections;

-- Populating the table done with SQL seed script.