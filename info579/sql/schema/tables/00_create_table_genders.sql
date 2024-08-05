-- Create the genders table in the specified database
DROP TABLE IF EXISTS stixd_corpus.genders;
CREATE TABLE stixd_corpus.genders (
    gender VARCHAR(7) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.genders;