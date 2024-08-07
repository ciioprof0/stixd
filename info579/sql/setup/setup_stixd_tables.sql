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