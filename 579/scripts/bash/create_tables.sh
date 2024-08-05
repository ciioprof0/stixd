#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Array of table creation scripts in the order they should be run
tables_scripts=(
    "../../sql/schema/tables/00_create_table_genders.sql"
    "../../sql/schema/tables/01_create_table_special_chars.sql"
    "../../sql/schema/tables/02_create_table_prohib_words.sql"
    "../../sql/schema/tables/03_create_table_prohib_intersections.sql"
    "../../sql/schema/tables/04_create_table_prolog_constraints.sql"
    "../../sql/schema/tables/05_create_table_stix_objects.sql"
    "../../sql/schema/tables/06_create_table_documents.sql"
    "../../sql/schema/tables/07_create_table_sentences.sql"
    "../../sql/schema/tables/08_create_table_validation_results.sql"
    "../../sql/schema/tables/09_create_table_lexicon.sql"
    "../../sql/schema/tables/20_create_table_obj_doc_jt.sql"
    "../../sql/schema/tables/21_create_table_doc_sent_jt.sql"
    "../../sql/schema/tables/22_create_table_doc_lex_jt.sql"
    "../../sql/schema/tables/23_create_table_sent_lex_jt.sql"
    "../../sql/schema/tables/24_create_table_obj_lex_jt.sql"
)

# Create tables
echo "Creating tables..."
for script in "${tables_scripts[@]}"; do
    echo "Running $script..."
    mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $script
done

echo "Tables created successfully."
