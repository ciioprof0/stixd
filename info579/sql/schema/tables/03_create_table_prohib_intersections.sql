-- Create the prohibited_intersections table in the specified database
DROP TABLE IF EXISTS stixd_corpus.prohibited_intersections;
CREATE TABLE stixd_corpus.prohibited_intersections (
    class1 VARCHAR(31),
    class2 VARCHAR(31),
    PRIMARY KEY (class1, class2)
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_intersections;