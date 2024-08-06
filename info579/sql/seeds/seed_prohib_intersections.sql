-- Insert the prohibited intersections if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'iv_finsg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'iv_finsg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'iv_infpl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'iv_infpl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adj_itr', 'adj_tr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adj_itr' AND class2 = 'adj_tr'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr_comp') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr_comp'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr_sup') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr_sup'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_finsg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_finsg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_infpl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_infpl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_pp') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_pp'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_intersections;
