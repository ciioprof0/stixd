#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Module for importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database.

This script reads the Clex lexicon file from the local directory, parses the content,
and imports the lexical entries into the stixd_corpus.lexicon table.
"""

# Import Standard Library Modules
import hashlib  # Provides SHA256 hash functionality
import os
import sys
from datetime import datetime, timezone
from typing import Optional, Tuple  # Type hinting

# Import Project-Specific Modules
from mysql_repository import MySQLRepository  # Provides database interaction
from gen_clex_uuid import generate_stix_uuid  # Function to generate STIX UUID

# Set Global Variables
# Small, test Clex file
CLEX_FILE_PATH = "lexicon/test_clex.pl"
STIX_TYPE = "x-stixd-clex"
UUID_VER = 4

DB_CONNECTION_PARAMS = {
    'host': 'localhost',
    'user': 'your_username',
    'password': 'your_password',
    'database': 'stixd_corpus'
}

# Define Script Classes
class ClexImporter:
    def __init__(self, db_repo: MySQLRepository, clex_file_path: str):
        self.db_repo = db_repo
        self.clex_file_path = clex_file_path

    def read_clex_file(self) -> str:
        """Reads the Clex file content from the given file path."""
        print(f"Reading Clex file: {self.clex_file_path}")
        with open(self.clex_file_path, 'r', encoding='utf-8') as file:
            print("Clex file read successfully.")
            return file.read()

    def parse_clex_line(self, line: str) -> Tuple[str, str, str, Optional[str]]:
        """Parses a single line of the Clex file to extract the word_tag, word_form, and optional arguments."""
        try:
            print(f"Parsing line: {line}")
            word_tag = line.split('(')[0].strip()
            parts = line.split('(')[1].rstrip(').').split(',')
            word_form = parts[0].strip().strip("'")
            logical_symbol = parts[1].strip()
            third_arg = parts[2].strip() if len(parts) > 2 else None
            print(f"Parsed values - word_tag: {word_tag}, word_form: {word_form}, logical_symbol: {logical_symbol}, third_arg: {third_arg}")
            return word_tag, word_form, logical_symbol, third_arg
        except IndexError as e:
            print(f"IndexError while parsing line: {line} - {e}")
            raise

    def generate_hash(self, word_tag: str, word_form: str) -> str:
        """Generates a SHA256 hash for the combination of word_tag and word_form."""
        hash_object = hashlib.sha256(f"{word_tag}{word_form}".encode('utf-8'))
        return hash_object.hexdigest()

    def import_clex_entries(self) -> None:
        """Main method to import Clex entries into the database."""
        try:
            # Generate a STIX UUID and create the corresponding entry in stix_objects
            # print(f"Generating STIX UUID with UUID_VER={UUID_VER}, STIX_TYPE={STIX_TYPE}, CLEX_FILE_PATH={CLEX_FILE_PATH}")
            # stix_uuid = generate_stix_uuid(UUID_VER, STIX_TYPE, CLEX_FILE_PATH)
            # print(f"Generated STIX UUID: {stix_uuid}")

            current_time = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S')
            stix_object = {
                'obj_id': 'x-stixd-clex--46eee763-676a-4324-9384-16bdb984bf1b',
                'type': 'x-stixd-clex',
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
            print(f"Saving STIX object: {stix_object}")
            self.db_repo.save_stix_object(stix_object)
            print("STIX object saved successfully.")

            clex_content = self.read_clex_file()
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
                        'third_arg': third_arg if third_arg is not None else 'NULL'
                    }
                    print(f"Saving lexicon entry: {entry}")
                    self.db_repo.save_entry(entry)
                    lex_id = self.db_repo.get_last_insert_id()
                    print(f"Linking lexicon entry (lex_id={lex_id}) with STIX object (obj_id={stix_object['obj_id']})")
                    self.db_repo.link_entry_with_stix(lex_id, stix_object['obj_id'])
                else:
                    print(f"Lexicon entry with hash {tag_form_hash} already exists. Linking with STIX object.")
                    self.db_repo.link_existing_entry(tag_form_hash)
            print("Clex entries imported successfully.")
        except Exception as e:
            print(f"An error occurred: {e}")

# Define Main Body of Script
if __name__ == "__main__":
    db_repo = MySQLRepository(DB_CONNECTION_PARAMS)
    clex_importer = ClexImporter(db_repo, CLEX_FILE_PATH)
    try:
        clex_importer.import_clex_entries()
        print("Script completed successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")