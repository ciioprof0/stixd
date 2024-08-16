#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/reset_database.py

""" Module for resetting the stixd_corpus database by running the SQL setup script. """

import os
import mysql.connector

def reset_database():
    """ Function to reset the stixd_corpus database by running the SQL setup script. """
    # Database connection parameters
    db_config = {
        'host': 'localhost',  # Update with your MySQL server host if different
        'user': 'your_username',  # Update with your MySQL username
        'password': 'your_password',  # Update with your MySQL password
        'database': 'stixd_corpus'
    }

    # Path to the SQL script
    sql_script_path = os.path.join(os.path.dirname(__file__),
                                '../../info579/sql/setup/setup_stixd_corpus.sql')

    try:
        # Establish a connection to the database
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Read the SQL script
        with open(sql_script_path, 'r', encoding='utf-8') as file:
            sql_script = file.read()

        # Split the script on 'DELIMITER' to handle separately
        parts = sql_script.split('DELIMITER //')

        # Execute the first part (before DELIMITER change)
        for statement in parts[0].split(';'):
            if statement.strip():
                cursor.execute(statement)

        # Execute the part with stored procedures (with // as delimiter)
        if len(parts) > 1:
            proc_statements = parts[1].split('//')
            for proc_statement in proc_statements:
                if proc_statement.strip():
                    cursor.execute(proc_statement)

        # Commit changes
        conn.commit()
        print("stixd_corpus database reset successfully.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        # Close the connection
        cursor.close()
        conn.close()

if __name__ == "__main__":
    reset_database()
