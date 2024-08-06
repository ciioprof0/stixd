#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Module for importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database.

This script fetches the Clex lexicon file from the provided URI, parses the content,
and imports the lexical entries into the stixd_corpus.lexicon table.
"""

# Import Standard Library Modules
import hashlib  # Provides SHA256 hash functionality
import requests  # Allows fetching files from URI
from typing import Optional, Tuple  # Type hinting

# Import Third-Party Modules
# pip install mysql-connector-python

# Import Project-Specific Modules
from db.mysql_repository import MySQLRepository  # Provides database interaction

# Set Global Variables
CLEX_URI = "https://github.com/Attempto/Clex/blob/master/clex_lexicon.pl"
DB_CONNECTION_PARAMS = {
    'host': 'localhost',
    'user': 'your_username',
    'password': 'your_password',
    'database': 'stixd_corpus'
}

# Define Script Classes
class ClexImporter:
    def __init__(self, db_repo: MySQLRepository, clex_uri: str):
        self.db_repo = db_repo
        self.clex_uri = clex_uri

    def fetch_clex_file(self) -> str:
        """Fetches the Clex file content from the given URI."""
        response = requests.get(self.clex_uri)
        response.raise_for_status()
        return response.text

    def parse_clex_line(self, line: str) -> Tuple[str, str, str, Optional[str]]:
        """Parses a single line of the Clex file to extract the word_tag, word_form, and optional arguments."""
        word_tag = line.split('(')[0].strip()
        parts = line.split('(')[1].split(',')
        word_form = parts[0].strip().strip("'")
        logical_symbol = parts[1].strip()
        third_arg = parts[2].strip().strip(').') if len(parts) > 2 else None
        return word_tag, word_form, logical_symbol, third_arg

    def generate_hash(self, word_tag: str, word_form: str) -> str:
        """Generates a SHA256 hash for the combination of word_tag and word_form."""
        hash_object = hashlib.sha256(f"{word_tag}{word_form}".encode('utf-8'))
        return hash_object.hexdigest()

    def import_clex_entries(self) -> None:
        """Main method to import Clex entries into the database."""
        clex_content = self.fetch_clex_file()
        for line in clex_content.splitlines():
            if not line.strip() or line.startswith('%'):
                continue  # Skip empty lines and comments
            word_tag, word_form, logical_symbol, third_arg = self.parse_clex_line(line)
            tag_form_hash = self.generate_hash(word_tag, word_form)

            if not self.db_repo.find_entry_by_id(tag_form_hash):
                entry = {
                    'word_tag': word_tag,
                    'word_form': word_form,
                    'tag_form_hash': tag_form_hash,
                    'logical_symbol': logical_symbol,
                    'third_arg': third_arg
                }
                self.db_repo.save_entry(entry)
            else:
                self.db_repo.link_existing_entry(tag_form_hash)
        print("Clex entries imported successfully.")

# Define Main Body of Script
if __name__ == "__main__":
    db_repo = MySQLRepository(DB_CONNECTION_PARAMS)
    clex_importer = ClexImporter(db_repo, CLEX_URI)
    try:
        clex_importer.import_clex_entries()
        print("Script completed successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
