#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run all setup scripts
./setup_database.sh
./create_tables.sh
./create_procedures.sh
./create_triggers.sh
./seed_tables.sh

echo "Database setup complete."
