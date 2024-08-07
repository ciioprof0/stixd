-- Insert the prohibited words if they do not exist per ACE 6.7 Lexicon Specification (seed_prohib_words.sql)
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'null' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'null'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'zero' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'zero'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'one' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'one'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'two' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'two'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'three' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'three'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'four' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'four'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'five' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'five'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'six' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'six'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'seven' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'seven'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eight' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eight'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nine' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nine'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'ten' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'ten'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eleven' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eleven'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'twelve' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'twelve'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'dozen' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'dozen'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'there' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'there'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'and' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'and'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'or' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'or'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'not' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'not'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'that' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'that'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'than' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'than'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'of' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'of'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'if' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'if'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'then' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'then'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'such' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'such'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'be' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'be'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'provably' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'provably'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'more' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'more'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'most' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'most'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'are' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'are'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'is' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'is'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'the' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'the'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'a' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'a'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'an' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'an'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'some' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'some'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'no' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'no'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'every' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'every'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'all' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'all'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'each' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'each'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'which' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'which'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'its' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'its'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'his' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'his'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'her' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'her'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'their' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'their'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'whose' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'whose'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'it' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'it'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'he' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'he'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'she' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'she'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'they' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'they'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'him' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'him'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'them' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'them'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'itself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'itself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'himself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'himself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'herself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'herself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'themselves' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'themselves'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'someone' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'someone'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'somebody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'somebody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'something' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'something'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nobody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nobody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nothing' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nothing'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everyone' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everyone'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everybody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everybody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everything' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everything'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'what' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'what'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'who' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'who'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'how' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'how'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'where' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'where'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'when' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'when'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_words;