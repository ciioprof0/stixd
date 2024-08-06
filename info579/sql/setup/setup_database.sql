-- Drop and recreate the database
SOURCE setup/create_database.sql;

-- Create tables
SOURCE schema/tables/create_table_genders.sql;
SOURCE schema/tables/create_table_special_chars.sql;
SOURCE schema/tables/create_table_prohib_words.sql;
SOURCE schema/tables/create_table_prohib_intersections.sql;
SOURCE schema/tables/create_table_prolog_constraints.sql;
SOURCE schema/tables/create_table_word_tags.sql;
SOURCE schema/tables/create_table_stix_objects.sql;
SOURCE schema/tables/create_table_validation_results.sql;
SOURCE schema/tables/create_table_documents.sql;
SOURCE schema/tables/create_table_sentences.sql;
SOURCE schema/tables/create_table_lexicon.sql;
SOURCE schema/tables/create_table_obj_doc_jt.sql;
SOURCE schema/tables/create_table_obj_lex_jt.sql;
SOURCE schema/tables/create_table_doc_sent_jt.sql;
SOURCE schema/tables/create_table_doc_lex_jt.sql;
SOURCE schema/tables/create_table_sent_lex_jt.sql;

-- Create procedures
SOURCE procedures/sp_check_lexicon_constraints.sql;
SOURCE procedures/sp_check_prolog_constraints.sql;
SOURCE procedures/sp_run_seed_scripts.sql;

-- Create triggers
SOURCE triggers/master_triggers_lexicon.sql;
-- SOURCE triggers/13_trg_check_prohib_intersections.sql;

-- Insert seed data
SOURCE seeds/seed_genders.sql;
SOURCE seeds/seed_prohib_words.sql;
SOURCE seeds/seed_prohib_intersections.sql;
SOURCE seeds/seed_prolog_constraints.sql;
SOURCE seeds/seed_spec_chars.sql;
SOURCE seeds/seed_word_tags.sql;
