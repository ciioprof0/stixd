-- Insert the special characters and their escape sequences if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '\\', '\\\\') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '\\'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '\'', '\'\'') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '\''
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '"', '\\"') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '"'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT ',', '\\,') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ','
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '.', '\\.') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '.'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT ';', '\\;') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ';'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT ':', '\\:') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ':'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '!', '\\!') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '!'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '(', '\\(') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '('
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT ')', '\\)') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ')'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '[', '\\[') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '['
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT ']', '\\]') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ']'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '{', '\\{') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '{'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '}', '\\}') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '}'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '|', '\\|') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '|'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '@', '\\@') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '@'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '#', '\\#') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '#'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '&', '\\&') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '&'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '^', '\\^') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '^'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '*', '\\*') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '*'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '?', '\\?') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '?'
);

INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT * FROM (SELECT '/', '\\/') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '/'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.special_characters;
