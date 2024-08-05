-- Create the sent_lex_jt table in the specified database
DROP TABLE IF EXISTS stixd_corpus.sent_lex_jt;
CREATE TABLE stixd_corpus.sent_lex_jt (
    sent_id INT,
    lex_id INT,
    PRIMARY KEY (sent_id, lex_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.sent_lex_jt;