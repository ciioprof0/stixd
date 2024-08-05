#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Array of seed scripts in the order they should be run
seeds_scripts=(
    "../../sql/seeds/31_seed_genders.sql"
    "../../sql/seeds/32_seed_special_chars.sql"
    "../../sql/seeds/33_seed_prohib_words.sql"
    "../../sql/seeds/34_seed_prohib_intersections.sql"
    "../../sql/seeds/35_seed_prolog_constraints.sql"
)

# Seed tables
echo "Seeding tables..."
for script in "${seeds_scripts[@]}"; do
    echo "Running $script..."
    mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $script
done

echo "Tables seeded successfully."