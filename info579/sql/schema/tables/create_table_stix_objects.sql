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