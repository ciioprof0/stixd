#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Array of trigger creation scripts in the order they should be run
triggers_scripts=(
    "../../sql/triggers/master_triggers_lexicon.sql"
)

# Create triggers
echo "Creating triggers..."
for script in "${triggers_scripts[@]}"; do
    echo "Running $script..."
    mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $script
done

echo "Triggers created successfully."
