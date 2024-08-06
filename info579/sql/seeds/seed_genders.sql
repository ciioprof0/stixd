-- Populate the genders table if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'undef') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'undef'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'neutr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'neutr'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'human') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'human'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'masc') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'masc'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'fem') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'fem'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.genders;
