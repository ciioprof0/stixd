-- Insert the special characters and their escape sequences
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq) VALUES
('\\', '\\\\'), ('\'', '\'\''), ('"', '\\"'), (',', '\\,'), ('.', '\\.'),
(';', '\\;'), (':', '\\:'), ('!', '\\!'), ('(', '\\('), (')', '\\)'),
('[', '\\['), (']', '\\]'), ('{', '\\{'), ('}', '\\}'), ('|', '\\|'), ('@', '\\@'),
('#', '\\#'), ('&', '\\&'), ('^', '\\^'), ('*', '\\*'), ('?', '\\?'), ('/', '\\/');

-- SELECT * FROM stixd_corpus.special_characters;