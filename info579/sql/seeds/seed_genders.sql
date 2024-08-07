-- Seed the genders table if they do not exist per ACE 6.7 Lexicon Specification (seed_genders.sql)
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'undef' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'undef'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'neutr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'neutr'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'human' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'human'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'masc' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'masc'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'fem' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'fem'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.genders;