-- Insert the prohibited words from ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prohibited_words (word) VALUES
('null'), ('zero'), ('one'), ('two'), ('three'), ('four'), ('five'), ('six'),
('seven'), ('eight'), ('nine'), ('ten'), ('eleven'), ('twelve'), ('dozen'), ('there'),
('and'), ('or'), ('not'), ('that'), ('than'), ('of'), ('if'), ('then'), ('such'),
('be'), ('provably'), ('more'), ('most'), ('are'), ('is'), ('the'), ('a'), ('an'),
('some'), ('no'), ('every'), ('all'), ('each'), ('which'), ('its'), ('his'), ('her'),
('their'), ('whose'), ('it'), ('he'), ('she'), ('they'), ('him'), ('them'),
('itself'), ('himself'), ('herself'), ('themselves'), ('someone'), ('somebody'),
('something'), ('nobody'), ('nothing'), ('everyone'), ('everybody'), ('everything'),
('what'), ('who'), ('how'), ('where'), ('when');

-- SELECT * FROM stixd_corpus.prohibited_words;