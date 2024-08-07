-- Create the database
DROP DATABASE IF EXISTS stixd_corpus;
CREATE DATABASE IF NOT EXISTS stixd_corpus
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;
-- SHOW DATABASES;

-- Create the stixd_corpus.genders table
-- DROP TABLE IF EXISTS stixd_corpus.genders;
CREATE TABLE IF NOT EXISTS stixd_corpus.genders (
    gender VARCHAR(7) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.genders;

-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.special_characters table
-- DROP TABLE IF EXISTS stixd_corpus.special_characters;
CREATE TABLE IF NOT EXISTS stixd_corpus.special_characters (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    spec_char CHAR(1) UNIQUE,
    esc_seq VARCHAR(10)
);
-- SHOW CREATE TABLE stixd_corpus.special_characters;

-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prohibited_words table
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_words;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_words (
    word VARCHAR(20) PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_words;

-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prohibited_intersections table
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_intersections;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_intersections (
    class1 VARCHAR(31),
    class2 VARCHAR(31),
    PRIMARY KEY (class1, class2)
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_intersections;

-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prolog_constraints table
-- DROP TABLE IF EXISTS stixd_corpus.prolog_constraints;
CREATE TABLE IF NOT EXISTS stixd_corpus.prolog_constraints (
    constraint_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(511),
    pattern VARCHAR(255),
    message VARCHAR(255),
    auto_correct BOOLEAN
);
-- SHOW CREATE TABLE stixd_corpus.prolog_constraints;

-- Create the stixd_corpus.stix_objects table
-- DROP TABLE IF EXISTS stixd_corpus.stix_objects;
CREATE TABLE IF NOT EXISTS stixd_corpus.stix_objects (
    obj_id VARCHAR(292) PRIMARY KEY,
    type VARCHAR(255),
    created_by_ref VARCHAR(255),
    description TEXT, -- Optional raw text description
    spec_version VARCHAR(8) DEFAULT '2.1',
    created TIMESTAMP,
    modified TIMESTAMP,
    revoked BOOLEAN,
    labels JSON,
    confidence INT CHECK (confidence BETWEEN 0 AND 100),
    lang VARCHAR(20) DEFAULT 'en',
    external_references JSON,
    object_marking_refs JSON,
    granular_markings JSON,
    extensions JSON,
    derived_from JSON,
    duplicate_of JSON,
    related_to JSON,
    other_properties JSON
);
-- SHOW CREATE TABLE stixd_corpus.stix_objects;

-- Populating table done from Python script.

-- Create the stixd_corpus.validation_results table
-- DROP TABLE IF EXISTS stixd_corpus.validation_results;
CREATE TABLE IF NOT EXISTS stixd_corpus.validation_results (
    val_id INT AUTO_INCREMENT PRIMARY KEY,
    obj_id VARCHAR(292),
    is_valid BOOLEAN,
    val_errors JSON,
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id)
);
-- SHOW CREATE TABLE stixd_corpus.validation_results;

-- Populating table done from Python script.

-- Create the stixd_corpus.documents table
-- DROP TABLE IF EXISTS stixd_corpus.documents;
CREATE TABLE IF NOT EXISTS stixd_corpus.documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_text LONGTEXT,
    raw_text_hash CHAR(64) UNIQUE,
    proc_text JSON,
    metadata JSON
);
-- SHOW CREATE TABLE stixd_corpus.documents;

-- Populating table done from Python script.

-- Create the stixd_corpus.sentences table
-- DROP TABLE IF EXISTS stixd_corpus.sentences;
CREATE TABLE IF NOT EXISTS stixd_corpus.sentences (
    sent_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_sent TEXT,
    raw_text_hash CHAR(64) UNIQUE,
    proc_sent JSON
);
-- SHOW CREATE TABLE stixd_corpus.sentences;

-- Populating table done from Python script.


-- Create the stixd_corpus.word_tags table in the specified database
-- DROP TABLE IF EXISTS stixd_corpus.word_tags;
CREATE TABLE IF NOT EXISTS stixd_corpus.word_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) NOT NULL,
    first_arg VARCHAR(31) NOT NULL,
    second_arg VARCHAR(31) NOT NULL,
    third_arg VARCHAR(31) DEFAULT NULL,
    word_class VARCHAR(31) NOT NULL
);

-- SHOW CREATE TABLE stixd_corpus.word_tags

-- Populating the table done with SQL seed script.


-- Create the stixd_corpus.lexicon table
DROP TABLE IF EXISTS stixd_corpus.lexicon;
CREATE TABLE IF NOT EXISTS stixd_corpus.lexicon (
    lex_id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12),
    word_form VARCHAR(99),
    logical_symbol VARCHAR(99),
    third_arg VARCHAR(15),
    tag_form_hash VARCHAR(64) UNIQUE,
    word_def TEXT,
    synsets JSON,
    tagsets JSON
);
-- SHOW CREATE TABLE stixd_corpus.lexicon;

-- Populating table done from Python script.


-- Create the stixd_corpus.obj_doc_jt table
-- DROP TABLE IF EXISTS stixd_corpus.obj_doc_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.obj_doc_jt (
    obj_id VARCHAR(292),
    doc_id INT,
    PRIMARY KEY (obj_id, doc_id),
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id)
);
-- SHOW CREATE TABLE stixd_corpus.obj_doc_jt;


-- Create the stixd_corpus.obj_lex_jt table
-- DROP TABLE IF EXISTS stixd_corpus.obj_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.obj_lex_jt (
    obj_id VARCHAR(292),
    lex_id INT,
    PRIMARY KEY (obj_id, lex_id),
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.obj_lex_jt;


-- Create the stixd_corpus.doc_lex_jt table
-- DROP TABLE IF EXISTS stixd_corpus.doc_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_lex_jt (
    doc_id INT,
    lex_id INT,
    PRIMARY KEY (doc_id, lex_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_lex_jt;


-- Create the stixd_corpus.doc_sent_jt table
-- DROP TABLE IF EXISTS stixd_corpus.doc_sent_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_sent_jt (
    doc_id INT,
    sent_id INT,
    PRIMARY KEY (doc_id, sent_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_sent_jt;


-- Create the stixd_corpus.sent_lex_jt table
-- DROP TABLE IF EXISTS stixd_corpus.sent_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.sent_lex_jt (
    sent_id INT,
    lex_id INT,
    PRIMARY KEY (sent_id, lex_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.sent_lex_jt;

-- Create procedure to check for prolog constraints
DELIMITER //
CREATE PROCEDURE stixd_corpus.check_prolog_constraints(IN word_form VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE constraint_violation VARCHAR(255);
    DECLARE constraint_message VARCHAR(255);

    DECLARE cur CURSOR FOR SELECT pattern, message FROM stixd_corpus.prolog_constraints;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO constraint_violation, constraint_message;
        IF done THEN
            LEAVE read_loop;
        END IF;
        IF NOT (word_form REGEXP constraint_violation) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = constraint_message;
        END IF;
    END LOOP;

    CLOSE cur;
END;
//
DELIMITER ;

-- Create main procedure to check lexicon constraints
DELIMITER //
CREATE PROCEDURE stixd_corpus.sp_check_lexicon_constraints(
    IN new_word_tag VARCHAR(12),
    IN new_word_form VARCHAR(99),
    IN new_logical_symbol VARCHAR(99),
    IN new_third_arg VARCHAR(15)
)
BEGIN
    DECLARE prohibited_word_found INT DEFAULT 0;
    DECLARE tag_form_hash VARCHAR(64);

    -- Step 1: Check prolog constraints for word_form
    CALL stixd_corpus.check_prolog_constraints(new_word_form);

    -- Step 2: Check prohibited words
    SELECT COUNT(*)
    INTO prohibited_word_found
    FROM stixd_corpus.prohibited_words
    WHERE word = new_word_form;

    IF prohibited_word_found > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'word_form contains a prohibited word';
    END IF;

    -- Step 3: Check prohibited intersections for word_form
    CALL stixd_corpus.check_prohib_intersections(new_word_form);

    -- Step 4: Generate the SHA256 hash for word_tag and word_form combination
    SET tag_form_hash = SHA2(CONCAT(new_word_tag, new_word_form), 256);

    -- Step 5: Check if the tag_form_hash already exists in the lexicon table
    IF EXISTS (SELECT 1 FROM stixd_corpus.lexicon WHERE tag_form_hash = tag_form_hash) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The combination of word_tag and word_form already exists in the lexicon table';
    END IF;

    -- Step 6: Ensure logical_symbol is not null if word_tag starts with adj_tr or dv_
    IF (new_word_tag LIKE 'adj_tr%' OR new_word_tag LIKE 'dv_%') THEN
        IF (new_logical_symbol IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'logical_symbol must be NOT NULL if word_tag starts with "adj_tr" or "dv_"';
        END IF;
    END IF;

    -- Step 7: Ensure third_arg is not null if word_tag starts with noun_ or pn
    IF (new_word_tag LIKE 'noun_%' OR new_word_tag LIKE 'pn%') THEN
        IF (new_third_arg IS NULL) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'third_arg must be NOT NULL if word_tag starts with "noun_" or "pn"';
        END IF;
    END IF;

    -- Step 8: Enforce the mutual exclusivity of logical_symbol and third_arg
    IF (new_logical_symbol IS NOT NULL AND new_third_arg IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'logical_symbol and third_arg cannot both be NOT NULL';
    END IF;
END//
//
DELIMITER ;


DELIMITER //

CREATE PROCEDURE stixd_corpus.run_seed_scripts()
BEGIN
    -- Seed Genders
    SET @sql = 'SOURCE ../seeds/seed_genders.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prohibited Words
    SET @sql = 'SOURCE ../seeds/seed_prohib_words.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prohibited Intersections
    SET @sql = 'SOURCE ../seeds/seed_prohib_intersections.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prolog Constraints
    SET @sql = 'SOURCE ../seeds/seed_prolog_constraints.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Word Tags
    SET @sql = 'SOURCE ../seeds/seed_word_tags.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Special Characters
    SET @sql = 'SOURCE ../seeds/seed_spec_chars.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Create master triggers for the lexicon table
DELIMITER //

CREATE TRIGGER stixd_corpus.master_trigger_before_insert
BEFORE INSERT ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_form, NEW.word_tag, NEW.third_arg);
END//

CREATE TRIGGER stixd_corpus.master_trigger_before_update
BEFORE UPDATE ON stixd_corpus.lexicon
FOR EACH ROW
BEGIN
    CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_form, NEW.word_tag, NEW.third_arg);
END//

DELIMITER ;

-- Populate the genders table if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'undef') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'undef'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'neutr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'neutr'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'human') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'human'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'masc') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'masc'
);

INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'fem') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'fem'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.genders;


-- Insert the prohibited intersections if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'iv_finsg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'iv_finsg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adv', 'iv_infpl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adv' AND class2 = 'iv_infpl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'adj_itr', 'adj_tr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'adj_itr' AND class2 = 'adj_tr'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_sg', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_sg' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_sg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_sg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_pl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_pl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'pndef_pl', 'noun_mass') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'pndef_pl' AND class2 = 'noun_mass'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr_comp') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr_comp'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'adj_itr_sup') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'adj_itr_sup'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_finsg') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_finsg'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_infpl') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_infpl'
);

INSERT INTO stixd_corpus.prohibited_intersections (class1, class2)
SELECT * FROM (SELECT 'prep', 'tv_pp') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE class1 = 'prep' AND class2 = 'tv_pp'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_intersections;


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

-- Insert the constraints only if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).', '^[a-zA-Z_$°][a-zA-Z0-9_$°-]*$', 'Invalid characters in word_form. Allowed characters are: a-z, A-Z, 0-9, -, _, $, °.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'The first character must not be a digit or a hyphen.', '^[^0-9-]', 'First character must not be a digit or a hyphen.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The first character must not be a digit or a hyphen.'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'Blank spaces are not allowed. Use hyphens instead of blank spaces.', '^.*[^ ].*$', 'Blank spaces are not allowed in word_form. Use hyphens instead.', TRUE) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Blank spaces are not allowed. Use hyphens instead of blank spaces.'
);

INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (SELECT 'Symbols special for Prolog (e.g., apostrophe) must be escaped.', '', 'Escape symbols special for Prolog (e.g., apostrophe).', TRUE) AS tmp
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

-- Insert data into the word_tags table if it does not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adv', 'PositiveForm', 'LogicalSymbol', NULL, 'Adverbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adv_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Adverbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adv_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Adverbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_itr', 'PositiveForm', 'LogicalSymbol', NULL, 'Intransitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_itr_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_itr_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_tr', 'PositiveForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_tr_comp', 'ComparativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'adj_tr_sup', 'SuperlativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'noun_sg', 'SingularForm', 'LogicalSymbol', 'Gender', 'Countable nouns') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'noun_pl', 'PluralForm', 'LogicalSymbol', 'Gender', 'Countable nouns') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'noun_mass', 'WordForm', 'LogicalSymbol', 'Gender', 'Mass nouns') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_mass' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Mass nouns'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'mn_sg', 'SingularForm', 'LogicalSymbol', NULL, 'Measurement nouns') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'mn_pl', 'PluralForm', 'LogicalSymbol', NULL, 'Measurement nouns') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'pn_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'pn_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'pndef_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'pndef_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'iv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Intransitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'iv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Intransitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'tv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Transitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'tv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Transitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'tv_pp', 'PastPartForm', 'LogicalSymbol', NULL, 'Transitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'dv_finsg', 'ThirdSgForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'dv_infpl', 'InfForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'dv_pp', 'PastPartForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);

INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT * FROM (SELECT 'prep', 'WordForm', 'LogicalSymbol', NULL, 'Prepositions') AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'prep' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Prepositions'
);

-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.word_tags;