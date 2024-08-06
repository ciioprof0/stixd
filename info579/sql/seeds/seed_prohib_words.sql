-- Insert the prohibited words if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'null') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'null'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'zero') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'zero'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'one') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'one'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'two') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'two'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'three') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'three'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'four') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'four'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'five') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'five'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'six') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'six'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'seven') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'seven'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eight') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eight'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nine') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nine'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'ten') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'ten'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eleven') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eleven'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'twelve') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'twelve'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'dozen') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'dozen'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'there') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'there'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'and') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'and'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'or') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'or'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'not') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'not'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'that') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'that'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'than') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'than'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'of') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'of'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'if') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'if'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'then') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'then'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'such') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'such'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'be') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'be'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'provably') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'provably'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'more') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'more'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'most') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'most'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'are') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'are'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'is') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'is'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'the') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'the'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'a') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'a'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'an') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'an'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'some') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'some'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'no') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'no'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'every') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'every'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'all') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'all'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'each') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'each'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'which') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'which'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'its') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'its'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'his') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'his'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'her') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'her'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'their') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'their'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'whose') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'whose'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'it') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'it'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'he') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'he'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'she') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'she'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'they') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'they'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'him') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'him'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'them') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'them'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'itself') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'itself'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'himself') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'himself'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'herself') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'herself'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'themselves') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'themselves'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'someone') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'someone'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'somebody') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'somebody'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'something') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'something'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nobody') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nobody'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nothing') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nothing'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everyone') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everyone'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everybody') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everybody'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everything') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everything'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'what') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'what'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'who') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'who'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'how') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'how'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'where') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'where'
);

INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'when') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'when'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_words;
