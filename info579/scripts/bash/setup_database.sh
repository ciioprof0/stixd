#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Path to MySQL client
MYSQL_PATH="/c/Program Files/MySQL/MySQL Server 8.0/bin/mysql"

# Absolute path to SQL files
SQL_PATH="/d/OneDrive/Code/hltms/stixd/stixd/info579/sql/setup"

# Create the database
echo "Creating database..."
"$MYSQL_PATH" -u $DB_USER -p$DB_PASSWORD < "$SQL_PATH/setup_database.sql"

echo "Database created successfully."