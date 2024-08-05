#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Database credentials
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_NAME="stixd_corpus"

# Create procedures
echo "Creating procedures..."
mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < ../../sql/procedures/17_prc_check_prolog_constraints.sql

echo "Procedures created successfully."