-- Populate the genders table from ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.genders (gender) VALUES
('undef'), ('neutr'), ('human'), ('masc'), ('fem');

SELECT * FROM stixd_corpus.genders;