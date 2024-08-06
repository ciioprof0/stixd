#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Create the database
echo "Creating database..."
mysql -u $DB_USER -p$DB_PASSWORD < ../../sql/setup/create_database.sql

echo "Database created successfully."