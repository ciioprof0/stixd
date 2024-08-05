#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Array of trigger creation scripts in the order they should be run
triggers_scripts=(
    "../../sql/triggers/11_trg_lexicon_preposition_gender.sql"
    "../../sql/triggers/12_trg_lexicon_preposition_check.sql"
    "../../sql/triggers/13_trg_lexicon_word_class_prep.sql"
    "../../sql/triggers/14_trg_lexicon_word_class_gender.sql"
    "../../sql/triggers/15_trg_lexicon_prohibited_words.sql"
    "../../sql/triggers/16_trg_lexicon_prohibited_intersections.sql"
    "../../sql/triggers/18_trg_lexicon_prolog_constraints.sql"
)

# Create triggers
echo "Creating triggers..."
for script in "${triggers_scripts[@]}"; do
    echo "Running $script..."
    mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $script
done

echo "Triggers created successfully."
