-- Insert the constraints with auto_correct flag only if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).', '^[a-zA-Z_$°][a-zA-Z0-9_$°-]*$', 'Invalid characters in word_form. Allowed characters are: a-z, A-Z, 0-9, -, _, $, °.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'The first character must not be a digit or a hyphen.', '^[^0-9-]', 'The first character must not be a digit or a hyphen.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The first character must not be a digit or a hyphen.'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'Blank spaces are not allowed. Use hyphens instead of blank spaces.', '^.*[^ ].*$', 'Blank spaces are not allowed in word_form. Use hyphens instead.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Blank spaces are not allowed. Use hyphens instead of blank spaces.'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'Symbols special for Prolog (e.g., apostrophe) must be escaped.', '', 'Symbols special for Prolog (e.g., apostrophe) must be escaped.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Symbols special for Prolog (e.g., apostrophe) must be escaped.'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'Capitalized words (e.g., proper names) must be in quotes, otherwise they would be considered variables by Prolog.', '', 'Capitalized words (e.g., proper names) must be in quotes.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Capitalized words (e.g., proper names) must be in quotes, otherwise they would be considered variables by Prolog.'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prolog_constraints;
