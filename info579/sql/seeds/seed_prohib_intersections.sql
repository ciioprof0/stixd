-- Seed the prohibited intersections if they do not exist per ACE 6.7 Lexicon Specification (seed_prohib_intersections.sql)
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'iv_finsg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'iv_finsg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'iv_infpl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'iv_infpl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adj_itr' COLLATE utf8mb4_unicode_ci, 'adj_tr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adj_itr' AND word_tag2 = 'adj_tr'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr_comp' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr_comp'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr_sup' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr_sup'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_finsg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_finsg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_infpl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_infpl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_pp' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_pp'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_intersections;
