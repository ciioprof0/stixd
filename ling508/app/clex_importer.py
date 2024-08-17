#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/clex_importer.py

"""
Module for importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database.

This script reads the Clex lexicon file from the local directory, parses the
content, and imports the lexical entries into the stixd_corpus.lexicon table.
"""

# Import Standard Library Modules
import argparse  # For command-line argument parsing
from datetime import datetime, timezone
from typing import Optional, Tuple  # Type hinting
import hashlib  # Provides SHA256 hash functionality
import requests  # Provides HTTP request functionality

# Import Project-Specific Modules
from ling508.app.gen_clex_uuid import generate_stix_uuid  # Function to generate STIX UUID
from ling508.db.mysql_repository import MySQLRepository  # Provides database interaction

# Set Global Variables
STIX_TYPE = "x-stixd-clex"
UUID_VER = 4

# Define Script Classes
class ClexImporter:
    """Class for importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database."""
    def __init__(self, db_repo: MySQLRepository, clex_file_path: str):
        self.db_repo = db_repo
        self.clex_file_path = clex_file_path

    def _read_clex_file(self) -> str:
        """Reads the Clex file content from the given file path."""
        with open(self.clex_file_path, 'r', encoding='utf-8') as file:
            clex_content = file.read()
        return clex_content

    def _parse_clex_line(self, line: str) -> Tuple[str, str, str, Optional[str]]:
        """Parses a single line of the Clex file to extract the word_tag,
        word_form, and optional arguments."""
        try:
            word_tag = line.split('(')[0].strip()
            parts = line.split('(')[1].rstrip(').').split(',')
            word_form = parts[0].strip().strip("'")
            logical_symbol = parts[1].strip()
            third_arg = parts[2].strip() if len(parts) > 2 else None
            return word_tag, word_form, logical_symbol, third_arg
        except IndexError:
            print(f"Error parsing line: {line}")
            return None, None, None, None

    def _generate_hash(self, word_tag: str, word_form: str) -> str:
        """Generates a SHA256 hash for the combination of word_tag and word_form."""
        hash_object = hashlib.sha256(f"{word_tag}{word_form}".encode('utf-8'))
        return hash_object.hexdigest()

    def import_clex_entries(self, uri: str) -> str:
        """Main method to import Clex entries into the database."""
        try:
            # Fetch Clex content from the given URI
            response = requests.get(uri, timeout=20)
            response.raise_for_status()
            clex_content = response.text

            # Prepare the STIX object metadata
            current_time = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S')
            stix_object = {
                'obj_id': generate_stix_uuid(UUID_VER, STIX_TYPE, uri),
                'type': STIX_TYPE,
                'created_by_ref': 'user',  # Replace with appropriate reference
                'description': 'ACE Common Lexicon Import',
                'spec_version': '2.1',
                'created': current_time,
                'modified': current_time,
                'revoked': False,
                'labels': '["lexicon"]',
                'confidence': 100,
                'lang': 'en',
                'external_references': '[]',
                'object_marking_refs': '[]',
                'granular_markings': '[]',
                'extensions': '[]',
                'derived_from': None,
                'duplicate_of': None,
                'related_to': '[]'
            }

            # Save the STIX object to the database
            self.db_repo.save_stix_object(stix_object)
            print(f"Saved STIX object with ID: {stix_object['obj_id']}")

            # Initialize counters
            total_entries = 0
            new_entries = 0
            updated_links = 0

            # Process each line in the Clex content
            for line in clex_content.splitlines():
                if not line.strip() or line.startswith('%'):
                    continue

                total_entries += 1

                # Parse the Clex line
                word_tag, word_form, logical_symbol, third_arg = self._parse_clex_line(line)
                if word_tag is None or word_form is None:
                    print(f"Skipping line due to parse error: {line}")
                    continue

                # Generate a unique hash for the word_tag and word_form
                tag_form_hash = self._generate_hash(word_tag, word_form)
                print(f"Generated hash: {tag_form_hash} for {word_tag} - {word_form}")

                # Check if the entry already exists in the lexicon
                existing_entry = self.db_repo.find_entry_by_id(tag_form_hash)
                if existing_entry:
                    print(f"Entry already exists for hash: {tag_form_hash}")
                    updated_links += 1
                    continue

                # Prepare the entry dictionary for insertion
                entry = {
                    'word_tag': word_tag,
                    'word_form': word_form,
                    'tag_form_hash': tag_form_hash,
                    'logical_symbol': logical_symbol,
                    'third_arg': third_arg if third_arg is not None else 'NULL'
                }

                # Save the entry to the lexicon table and retrieve its lex_id
                lex_id = self.db_repo.save_entry(entry, 'lexicon')
                if lex_id:
                    print(f"Linking lex_id {lex_id} with stix_object_id {stix_object['obj_id']}")
                    # Link the entry to the STIX object in the junction table
                    self.db_repo.link_entry_with_stix(lex_id, stix_object['obj_id'])
                    new_entries += 1
                else:
                    print(f"Error: Failed to retrieve lex_id after inserting entry for {word_tag} - {word_form}")

            # Provide detailed feedback to the user
            feedback = (
                f"Import successful.\n"
                f"New entries imported:    {new_entries:,}\n"
                f"Existing entries linked: {updated_links:,}\n"
                f"===============================\n"
                f"Total entries processed: {total_entries:,}"
            )
            return feedback

        except Exception as e:
            print(f"Exception during import: {e}")
            raise e


if __name__ == "__main__":
    # Argument parsing
    parser = argparse.ArgumentParser(
        description='Import ACE Common Lexicon (Clex) into the STIX-D Corpus Database.')
    parser.add_argument('clex_file_path', nargs='?', default='lexicon/test_clex.pl',
        help='Path to the Clex file to be imported (default: lexicon/test_clex.pl)')
    args = parser.parse_args()

    # Instantiate repository and importer with the provided file path
    DB_REPO = MySQLRepository()
    importer = ClexImporter(DB_REPO, args.clex_file_path)

    # Use the provided file path as the URI
    RESULT = importer.import_clex_entries(args.clex_file_path)
    print(RESULT)
