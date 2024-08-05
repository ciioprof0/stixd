-- Insert the constraints with auto_correct flag
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct) VALUES
('The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).', '^[a-zA-Z_$°][a-zA-Z0-9_$°-]*$', 'Invalid characters in word_form. Allowed characters are: a-z, A-Z, 0-9, -, _, $, °.', TRUE),
('The first character must not be a digit or a hyphen.', '^[^0-9-]', 'The first character must not be a digit or a hyphen.', TRUE),
('Blank spaces are not allowed. Use hyphens instead of blank spaces.', '^.*[^ ].*$', 'Blank spaces are not allowed in word_form. Use hyphens instead.', TRUE),
('Symbols special for Prolog (e.g., apostrophe) must be escaped.', '', 'Symbols special for Prolog (e.g., apostrophe) must be escaped.', TRUE),
('Capitalized words (e.g., proper names) must be in quotes, otherwise they would be considered variables by Prolog.', '', 'Capitalized words (e.g., proper names) must be in quotes.', TRUE);

-- SELECT * FROM stixd_corpus.prolog_constraints;