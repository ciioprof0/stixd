-- Create the database (create_database.sql)
DROP DATABASE IF EXISTS stixd_corpus;
CREATE DATABASE IF NOT EXISTS stixd_corpus
    CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;
-- SHOW DATABASES;

-- Create the stixd_corpus.special_characters table (create_table_spec_chars.sql)
-- DROP TABLE IF EXISTS stixd_corpus.special_characters;
CREATE TABLE IF NOT EXISTS stixd_corpus.special_characters (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    spec_char CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    esc_seq VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);
-- SHOW CREATE TABLE stixd_corpus.special_characters;
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prohibited_words table (create_table_prohib_words.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_words;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_words (
    word VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_words;
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prohibited_intersections table (create_table_prohib_intersections.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prohibited_intersections;
CREATE TABLE IF NOT EXISTS stixd_corpus.prohibited_intersections (
    word_tag1 VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    word_tag2 VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY (word_tag1, word_tag2)
);
-- SHOW CREATE TABLE stixd_corpus.prohibited_intersections;
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.prolog_constraints table (create_table_prolog_constraints.sql)
-- DROP TABLE IF EXISTS stixd_corpus.prolog_constraints;
CREATE TABLE IF NOT EXISTS stixd_corpus.prolog_constraints (
    constraint_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(511) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    pattern VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    message VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    auto_correct BOOLEAN
);
-- SHOW CREATE TABLE stixd_corpus.prolog_constraints;
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.genders table (create_table_genders.sql)
-- DROP TABLE IF EXISTS stixd_corpus.genders;
CREATE TABLE IF NOT EXISTS stixd_corpus.genders (
    gender VARCHAR(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY
);
-- SHOW CREATE TABLE stixd_corpus.genders;
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.word_tags table in the specified database (create_table_word_tags.sql)
-- DROP TABLE IF EXISTS stixd_corpus.word_tags;
CREATE TABLE IF NOT EXISTS stixd_corpus.word_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    first_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    second_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    third_arg VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
);
-- SHOW CREATE TABLE stixd_corpus.word_tags
-- Populating the table done with SQL seed script.

-- Create the stixd_corpus.stix_objects table (create_table_stix_objects.sql)
-- DROP TABLE IF EXISTS stixd_corpus.stix_objects;
CREATE TABLE IF NOT EXISTS stixd_corpus.stix_objects (
    obj_id VARCHAR(292) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
    type VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_by_ref VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, -- Optional raw text description
    spec_version VARCHAR(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '2.1',
    created TIMESTAMP,
    modified TIMESTAMP,
    revoked BOOLEAN,
    labels JSON,
    confidence INT CHECK (confidence BETWEEN 0 AND 100),
    lang VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'en',
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

-- Create the stixd_corpus.validation_results table (create_table_validation_results.sql)
-- DROP TABLE IF EXISTS stixd_corpus.validation_results;
CREATE TABLE IF NOT EXISTS stixd_corpus.validation_results (
    val_id INT AUTO_INCREMENT PRIMARY KEY,
    obj_id VARCHAR(292) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    is_valid BOOLEAN,
    val_errors JSON,
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id)
);
-- SHOW CREATE TABLE stixd_corpus.validation_results;
-- Populating table done from Python script.

-- Create the stixd_corpus.documents table (create_table_documents.sql)
-- DROP TABLE IF EXISTS stixd_corpus.documents;
CREATE TABLE IF NOT EXISTS stixd_corpus.documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    raw_text_hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    proc_text JSON,
    metadata JSON
);
-- SHOW CREATE TABLE stixd_corpus.documents;
-- Populating table done from Python script.

-- Create the stixd_corpus.sentences table (create_table_sentences.sql)
-- DROP TABLE IF EXISTS stixd_corpus.sentences;
CREATE TABLE IF NOT EXISTS stixd_corpus.sentences (
    sent_id INT AUTO_INCREMENT PRIMARY KEY,
    raw_sent TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    raw_text_hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    proc_sent JSON
);
-- SHOW CREATE TABLE stixd_corpus.sentences;
-- Populating table done from Python script.

-- Create the stixd_corpus.lexicon table (create_table_lexicon.sql)
DROP TABLE IF EXISTS stixd_corpus.lexicon;
CREATE TABLE IF NOT EXISTS stixd_corpus.lexicon (
    lex_id INT AUTO_INCREMENT PRIMARY KEY,
    word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    logical_symbol VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    third_arg VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci UNIQUE,
    word_def TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    synsets JSON,
    tagsets JSON
);
-- SHOW CREATE TABLE stixd_corpus.lexicon;
-- Populating table done from Python script.

-- Create the stixd_corpus.doc_lex_jt table (create_table_doc_lex_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.doc_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_lex_jt (
    doc_id INT,
    lex_id INT,
    PRIMARY KEY (doc_id, lex_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_lex_jt;
-- Populating table done from primary tables.

-- Create the stixd_corpus.doc_sent_jt table (create_table_doc_sent_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.doc_sent_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_sent_jt (
    doc_id INT,
    sent_id INT,
    PRIMARY KEY (doc_id, sent_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_sent_jt;
-- Populating table done from primary tables.

-- Create the stixd_corpus.doc_sent_jt table (create_table_doc_sent_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.doc_sent_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.doc_sent_jt (
    doc_id INT,
    sent_id INT,
    PRIMARY KEY (doc_id, sent_id),
    FOREIGN KEY (doc_id) REFERENCES stixd_corpus.documents(doc_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id)
);
-- SHOW CREATE TABLE stixd_corpus.doc_sent_jt;
-- Populating table done from primary tables.

-- Create the stixd_corpus.obj_lex_jt table (create_table_obj_lex_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.obj_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.obj_lex_jt (
    obj_id VARCHAR(292),
    lex_id INT,
    PRIMARY KEY (obj_id, lex_id),
    FOREIGN KEY (obj_id) REFERENCES stixd_corpus.stix_objects(obj_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.obj_lex_jt;
-- Populating table done from primary tables.

-- Create the stixd_corpus.sent_lex_jt table (create_table_sent_lex_jt.sql)
-- DROP TABLE IF EXISTS stixd_corpus.sent_lex_jt;
CREATE TABLE IF NOT EXISTS stixd_corpus.sent_lex_jt (
    sent_id INT,
    lex_id INT,
    PRIMARY KEY (sent_id, lex_id),
    FOREIGN KEY (sent_id) REFERENCES stixd_corpus.sentences(sent_id),
    FOREIGN KEY (lex_id) REFERENCES stixd_corpus.lexicon(lex_id)
);
-- SHOW CREATE TABLE stixd_corpus.sent_lex_jt;
-- Populating table done from primary tables.

-- Create procedure to generate and return hash (sp_gen_hashes.sql)
DELIMITER //

CREATE PROCEDURE stixd_corpus.sp_gen_hashes(
    IN new_word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    OUT tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    -- Generate the SHA256 hash for word_tag and word_form combination
    SET tag_form_hash = SHA2(CONCAT(new_word_tag, new_word_form), 256);
END;
//
DELIMITER ;


-- Create procedure to check for prolog constraints (sp_check_prolog_constraints.sql)
DELIMITER //
CREATE PROCEDURE stixd_corpus.sp_check_prolog_constraints(IN word_form VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE constraint_violation VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE constraint_message VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

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

-- Create procedure to check for prohibited word_class intersections  (sp_check_prohib_intersections.sql)
DELIMITER //

CREATE PROCEDURE stixd_corpus.sp_check_prohib_intersections(
    IN new_word_tag VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE class_check INT DEFAULT 0;

    -- Get the word_tags from the lexicon table
    DECLARE new_word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_preposition INT;

    SELECT word_class INTO new_word_class FROM stixd_corpus.word_tags WHERE word_tag = new_word_tag;
    SELECT preposition INTO new_preposition FROM stixd_corpus.lexicon WHERE word_form = new_word_form;

    -- Check first condition
    SELECT COUNT(*)
    INTO class_check
    FROM stixd_corpus.prohibited_intersections
    WHERE word_tag1 = new_word_class
      AND word_tag2 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = new_preposition);

    IF class_check > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This combination of word_classes is prohibited';
    END IF;

    -- Reset the variable
    SET class_check = 0;

    -- Check second condition
    SELECT COUNT(*)
    INTO class_check
    FROM stixd_corpus.prohibited_intersections
    WHERE word_tag2 = new_word_class
      AND word_tag1 IN (SELECT word_class
                     FROM stixd_corpus.lexicon
                     WHERE lex_id = new_preposition);

    IF class_check > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This combination of word_classes is prohibited';
    END IF;
END;
//
DELIMITER ;

-- Create main procedure to check lexicon constraints (sp_check_lexicon_constraints.sql)
DELIMITER //
CREATE PROCEDURE stixd_corpus.sp_check_lexicon_constraints(
    IN new_word_tag VARCHAR(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_word_form VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_logical_symbol VARCHAR(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN new_third_arg VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE prohibited_word_found INT DEFAULT 0;
    DECLARE tag_form_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_word_class VARCHAR(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    DECLARE new_preposition INT DEFAULT NULL;

    -- Step 1: Check prolog constraints for word_form
    CALL stixd_corpus.sp_check_prolog_constraints(new_word_form);

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
    CALL stixd_corpus.sp_check_prohib_intersections(new_word_tag, new_word_form);

    -- Step 4: Generate and validate hashes
    CALL stixd_corpus.sp_gen_hashes(new_word_tag, new_word_form, tag_form_hash);

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
END //
//
DELIMITER ;


-- Create master triggers for the lexicon table (master_triggers_lexicon.sql)
-- DELIMITER //

-- CREATE TRIGGER stixd_corpus.master_trigger_before_insert
-- BEFORE INSERT ON stixd_corpus.lexicon
-- FOR EACH ROW
-- BEGIN
--     DECLARE calculated_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
--     
--     -- Call the procedure to generate hash
--     CALL stixd_corpus.sp_gen_hashes(NEW.word_tag, NEW.word_form, calculated_hash);
--     
--     -- Set the hash if it is missing or incorrect
--     IF (NEW.tag_form_hash IS NULL OR NEW.tag_form_hash != calculated_hash) THEN
--         SET NEW.tag_form_hash = calculated_hash;
--     END IF;

--     -- Call the procedure to check lexicon constraints
--     CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_tag, NEW.word_form, NEW.logical_symbol, NEW.third_arg);
-- END;
-- //

-- CREATE TRIGGER stixd_corpus.master_trigger_before_update
-- BEFORE UPDATE ON stixd_corpus.lexicon
-- FOR EACH ROW
-- BEGIN
--     DECLARE calculated_hash VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--     -- Call the procedure to generate hash
--     CALL stixd_corpus.sp_gen_hashes(NEW.word_tag, NEW.word_form, calculated_hash);
--     
--     -- Validate and update the hash
--     IF (NEW.tag_form_hash IS NULL OR NEW.tag_form_hash != calculated_hash) THEN
--         SET NEW.tag_form_hash = calculated_hash;
--     END IF;

--     -- Call the procedure to check lexicon constraints
--     CALL stixd_corpus.sp_check_lexicon_constraints(NEW.word_tag, NEW.word_form, NEW.logical_symbol, NEW.third_arg);
-- END;
-- //
-- DELIMITER ;


-- Insert the special characters and their escape sequences if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '\\', '\\\\' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '\\'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '\'', '\'' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '\''
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '"', '\\"' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '"'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT ',', '\\,' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ','
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '.', '\\.' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '.'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT ';', '\\;' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ';'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT ':', '\\:' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ':'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '!', '\\!' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '!'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '(', '\\(' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '('
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT ')', '\\)' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ')'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '[', '\\[' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '['
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT ']', '\\]' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = ']'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '{', '\\{' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '{'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '}', '\\}' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '}'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '|', '\\|' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '|'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '@', '\\@' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '@'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '#', '\\#' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '#'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '&', '\\&' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '&'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '^', '\\^' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '^'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '*', '\\*' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '*'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '?', '\\?' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '?'
);
INSERT INTO stixd_corpus.special_characters (spec_char, esc_seq)
SELECT '/', '\\/' FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.special_characters WHERE spec_char = '/'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.special_characters;

-- Insert the prohibited words if they do not exist per ACE 6.7 Lexicon Specification (seed_prohib_words.sql)
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'null' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'null'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'zero' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'zero'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'one' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'one'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'two' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'two'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'three' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'three'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'four' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'four'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'five' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'five'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'six' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'six'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'seven' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'seven'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eight' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eight'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nine' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nine'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'ten' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'ten'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'eleven' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'eleven'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'twelve' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'twelve'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'dozen' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'dozen'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'there' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'there'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'and' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'and'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'or' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'or'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'not' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'not'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'that' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'that'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'than' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'than'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'of' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'of'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'if' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'if'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'then' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'then'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'such' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'such'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'be' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'be'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'provably' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'provably'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'more' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'more'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'most' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'most'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'are' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'are'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'is' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'is'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'the' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'the'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'a' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'a'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'an' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'an'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'some' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'some'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'no' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'no'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'every' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'every'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'all' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'all'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'each' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'each'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'which' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'which'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'its' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'its'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'his' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'his'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'her' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'her'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'their' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'their'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'whose' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'whose'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'it' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'it'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'he' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'he'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'she' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'she'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'they' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'they'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'him' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'him'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'them' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'them'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'itself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'itself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'himself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'himself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'herself' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'herself'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'themselves' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'themselves'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'someone' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'someone'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'somebody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'somebody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'something' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'something'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nobody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nobody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'nothing' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'nothing'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everyone' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everyone'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everybody' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everybody'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'everything' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'everything'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'what' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'what'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'who' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'who'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'how' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'how'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'where' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'where'
);
INSERT INTO stixd_corpus.prohibited_words (word)
SELECT * FROM (SELECT 'when' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_words WHERE word = 'when'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_words;

-- Seed the prohibited intersections if they do not exist per ACE 6.7 Lexicon Specification (seed_prohib_intersections.sql)
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'iv_finsg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'iv_finsg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adv' COLLATE utf8mb4_unicode_ci, 'iv_infpl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adv' AND word_tag2 = 'iv_infpl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'adj_itr' COLLATE utf8mb4_unicode_ci, 'adj_tr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'adj_itr' AND word_tag2 = 'adj_tr'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_sg' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_sg' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_sg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_sg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_pl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_pl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'pndef_pl' COLLATE utf8mb4_unicode_ci, 'noun_mass' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'pndef_pl' AND word_tag2 = 'noun_mass'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr_comp' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr_comp'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'adj_itr_sup' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'adj_itr_sup'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_finsg' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_finsg'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_infpl' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_infpl'
);
INSERT INTO stixd_corpus.prohibited_intersections (word_tag1, word_tag2)
SELECT * FROM (SELECT 'prep' COLLATE utf8mb4_unicode_ci, 'tv_pp' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prohibited_intersections WHERE word_tag1 = 'prep' AND word_tag2 = 'tv_pp'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prohibited_intersections;

-- Insert the constraints with auto_correct flag only if they do not exist per ACE 6.7 Lexicon Specification
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (
    SELECT
        'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).',
        '^[a-zA-Z_$°][a-zA-Z0-9_$°-]*$' COLLATE utf8mb4_unicode_ci,
        'Invalid characters in word_form. Allowed characters are: a-z, A-Z, 0-9, -, _, $, °.',
        TRUE
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The word form must contain only lower and upper case letters (a-z, A-Z), digits (0-9), hyphens (-), underscores (_), dollar signs ($), and degree signs (°).'
);
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (
    SELECT
        'The first character must not be a digit or a hyphen.',
        '^[^0-9-]' COLLATE utf8mb4_unicode_ci,
        'First character must not be a digit or a hyphen.',
        TRUE
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'The first character must not be a digit or a hyphen.'
);
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (
    SELECT
        'Blank spaces are not allowed. Use hyphens instead of blank spaces.',
        '^.*[^ ].*$' COLLATE utf8mb4_unicode_ci,
        'Blank spaces are not allowed in word_form. Use hyphens instead.',
        TRUE
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Blank spaces are not allowed. Use hyphens instead of blank spaces.'
);
-- INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
-- SELECT * FROM (
--     SELECT
--         'Symbols special for Prolog (e.g., apostrophe) must be escaped.',
--         '\\\'',
--         'Escape symbols special for Prolog (e.g., apostrophe).',
--         TRUE
-- ) AS tmp
-- WHERE NOT EXISTS (
--     SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Symbols special for Prolog (e.g., apostrophe) must be escaped.'
-- );
INSERT INTO stixd_corpus.prolog_constraints (description, pattern, message, auto_correct)
SELECT * FROM (
    SELECT
        'Capitalized words (e.g., proper names) must be in quotes, otherwise they would be considered variables by Prolog.',
        '^[A-Z][a-z]+' COLLATE utf8mb4_unicode_ci,
        'Capitalized words (e.g., proper names) must be in quotes.',
        TRUE
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.prolog_constraints WHERE description = 'Capitalized words (e.g., proper names) must be in quotes, otherwise they would be considered variables by Prolog.'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.prolog_constraints;

-- Seed the genders table if they do not exist per ACE 6.7 Lexicon Specification (seed_genders.sql)
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'undef' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'undef'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'neutr' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'neutr'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'human' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'human'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'masc' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'masc'
);
INSERT INTO stixd_corpus.genders (gender)
SELECT * FROM (SELECT 'fem' COLLATE utf8mb4_unicode_ci) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.genders WHERE gender = 'fem'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.genders;

-- Seed word_tags table if it does not exist per ACE 6.7 Lexicon Specification (seed_word_tags.sql)
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv', 'PositiveForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adv_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Adverbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adv_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Adverbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr', 'PositiveForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr_comp', 'ComparativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_itr_sup', 'SuperlativeForm', 'LogicalSymbol', NULL, 'Intransitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_itr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr', 'PositiveForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr' AND first_arg = 'PositiveForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr_comp', 'ComparativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_comp' AND first_arg = 'ComparativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'adj_tr_sup', 'SuperlativeForm', 'LogicalSymbol', 'Preposition', 'Transitive adjectives'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'adj_tr_sup' AND first_arg = 'SuperlativeForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Transitive adjectives'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_sg', 'SingularForm', 'LogicalSymbol', 'Gender', 'Countable nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_pl', 'PluralForm', 'LogicalSymbol', 'Gender', 'Countable nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Countable nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'noun_mass', 'WordForm', 'LogicalSymbol', 'Gender', 'Mass nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'noun_mass' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Mass nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'mn_sg', 'SingularForm', 'LogicalSymbol', NULL, 'Measurement nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_sg' AND first_arg = 'SingularForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'mn_pl', 'PluralForm', 'LogicalSymbol', NULL, 'Measurement nouns'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'mn_pl' AND first_arg = 'PluralForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Measurement nouns'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pn_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pn_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pn_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pndef_sg', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_sg' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'pndef_pl', 'WordForm', 'LogicalSymbol', 'Gender', 'Proper names'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'pndef_pl' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Gender' AND word_class = 'Proper names'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'iv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Intransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'iv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Intransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'iv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Intransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_finsg', 'ThirdSgForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_infpl', 'InfForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'tv_pp', 'PastPartForm', 'LogicalSymbol', NULL, 'Transitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'tv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Transitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_finsg', 'ThirdSgForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_finsg' AND first_arg = 'ThirdSgForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_infpl', 'InfForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_infpl' AND first_arg = 'InfForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'dv_pp', 'PastPartForm', 'LogicalSymbol', 'Preposition', 'Ditransitive verbs'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'dv_pp' AND first_arg = 'PastPartForm' AND second_arg = 'LogicalSymbol' AND third_arg = 'Preposition' AND word_class = 'Ditransitive verbs'
);
INSERT INTO stixd_corpus.word_tags (word_tag, first_arg, second_arg, third_arg, word_class)
SELECT 'prep', 'WordForm', 'LogicalSymbol', NULL, 'Prepositions'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM stixd_corpus.word_tags WHERE word_tag = 'prep' AND first_arg = 'WordForm' AND second_arg = 'LogicalSymbol' AND third_arg IS NULL AND word_class = 'Prepositions'
);
-- Verify the data has been inserted correctly
-- SELECT * FROM stixd_corpus.word_tags;