#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/clex_importer.py

"""
Module for importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database.

This script reads the Clex lexicon file from the local directory, parses the
content, and imports the lexical entries into the stixd_corpus.lexicon table.
"""

# Import Standard Library Modules
from datetime import datetime, timezone
from typing import Optional, Tuple  # Type hinting
import hashlib  # Provides SHA256 hash functionality
import requests  # Provides HTTP request functionality

# Import Project-Specific Modules
from ling508.app.gen_clex_uuid import generate_stix_uuid  # Function to generate STIX UUID
from ling508.db.mysql_repository import MySQLRepository  # Provides database interaction

# Set Global Variables
# Small, test Clex file
CLEX_FILE_PATH = "lexicon/test_clex.pl"
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
        # Add your code here to read the Clex file content
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
            pass

    def _generate_hash(self, word_tag: str, word_form: str) -> str:
        """Generates a SHA256 hash for the combination of word_tag and word_form."""
        hash_object = hashlib.sha256(f"{word_tag}{word_form}".encode('utf-8'))
        return hash_object.hexdigest()

    def import_clex_entries(self, uri: str) -> str:
        """Main method to import Clex entries into the database."""
        try:
            response = requests.get(uri, timeout=20)
            response.raise_for_status()
            clex_content = response.text

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
            self.db_repo.save_stix_object(stix_object)

            for line in clex_content.splitlines():
                if not line.strip() or line.startswith('%'):
                    continue
                word_tag, word_form, logical_symbol, third_arg = self._parse_clex_line(line)
                tag_form_hash = self._generate_hash(word_tag, word_form)

                if not self.db_repo.find_entry_by_id(tag_form_hash):
                    entry = {
                        'word_tag': word_tag,
                        'word_form': word_form,
                        'tag_form_hash': tag_form_hash,
                        'logical_symbol': logical_symbol,
                        'third_arg': third_arg if third_arg is not None else 'NULL'
                    }
                    self.db_repo.save_entry(entry)
                    lex_id = self.db_repo.get_last_insert_id()
                    self.db_repo.link_entry_with_stix(lex_id, stix_object['obj_id'])
                else:
                    self.db_repo.link_existing_entry(tag_form_hash)
            return "Import successful"
        except Exception as e:
            raise e

if __name__ == "__main__":
    DB_REPO = MySQLRepository()
    importer = ClexImporter(DB_REPO, CLEX_FILE_PATH)
    RESULT = importer.import_clex_entries(CLEX_FILE_PATH)
    print(RESULT)
