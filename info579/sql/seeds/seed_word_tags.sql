-- Seed word_tags table if it does not exist per ACE 6.7 Lexicon Specification (seed_word_tags.sql)
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv', 'PositiveForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr', 'PositiveForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr', 'PositiveForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr_comp', 'ComparativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr_sup', 'SuperlativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_sg', 'SingularForm', 'LogicalSymbol', 'Gender', 'Countable nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_pl', 'PluralForm', 'LogicalSymbol', 'Gender', 'Countable nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_mass', 'WordForm', 'LogicalSymbol', 'Gender', 'Mass nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_mass' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Mass nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'mn_sg', 'SingularForm', 'LogicalSymbol', NULL, 'Measurement nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'mn_pl', 'PluralForm', 'LogicalSymbol', NULL, 'Measurement nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pn_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pn_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pndef_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pndef_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'iv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Intransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'iv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Intransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_pp', 'PastPartForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_finsg', 'ThirdSgForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_infpl', 'InfForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_pp', 'PastPartForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'prep', 'WordForm', 'LogicalSymbol', NULL, 'Prepositions'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'prep' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Prepositions'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.word_tags;