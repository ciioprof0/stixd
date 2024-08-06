#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Array of stored procedure scripts in the order they should be run
procedures_scripts=(
    "../../sql/procedures/sp_check_prolog_constraints.sql"
    "../../sql/procedures/sp_check_lexicon_constraints.sql"
)

# Create procedures
echo "Creating procedures..."
for script in "${procedures_scripts[@]}"; do
    echo "Running $script..."
    mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $script
done