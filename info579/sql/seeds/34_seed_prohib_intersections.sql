-- Insert the prohibited intersections from ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prohibited_intersections (class1, class2) VALUES
('adv', 'noun_sg'), ('adv', 'noun_pl'), ('adv', 'noun_mass'), ('adv', 'iv_finsg'),
('adv', 'iv_infpl'), ('adj_itr', 'adj_tr'), ('pndef_sg', 'noun_sg'),
('pndef_sg', 'noun_pl'), ('pndef_sg', 'noun_mass'), ('pndef_pl', 'noun_sg'),
('pndef_pl', 'noun_pl'), ('pndef_pl', 'noun_mass'), ('prep', 'adj_itr'),
('prep', 'adj_itr_comp'), ('prep', 'adj_itr_sup'), ('prep', 'tv_finsg'),
('prep', 'tv_infpl'), ('prep', 'tv_pp');

-- SELECT * FROM stixd_corpus.prohibited_intersections;