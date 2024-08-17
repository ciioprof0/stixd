#!/usr/bin/env python
# -*- coding: utf-8 -*-
# db/mysql_repository.py

"""
Module for interacting with a MySQL database.
"""

import mysql.connector  # MySQL database connector
from typing import Any, Dict, List, Optional, Tuple
from ling508.db.repository import AbstractRepository  # Abstract base class for repository pattern

# Database connection parameters
DB_CONNECTION_PARAMS = {
    'host': 'localhost',
    'user': 'your_username',
    'password': 'your_password',
    'database': 'stixd_corpus'
}

class MySQLRepository(AbstractRepository):
    """
    MySQL Repository for managing database interactions.
    """

    def __init__(self):
        """
        Initialize the MySQL repository with connection parameters.
        """
        self.connection_params = DB_CONNECTION_PARAMS

    def _connect(self):
        """
        Establish a connection to the MySQL database.
        """
        return mysql.connector.connect(**self.connection_params)

    def load_entries(self) -> List[Dict[str, Any]]:
        """
        Load all entries from the lexicon table.
        """
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM lexicon")
        rows = cursor.fetchall()
        conn.close()
        return [self._map_row_to_entry(row) for row in rows]

    def save_entry(self, entry: Dict[str, Any], table_name: str) -> int:
        """
        Save a single entry to the specified table and return the last inserted ID.
        """
        conn = self._connect()
        cursor = conn.cursor()
        lex_id = None
        try:
            # Construct the INSERT statement dynamically based on the table name
            columns = ', '.join(entry.keys())
            placeholders = ', '.join(['%s'] * len(entry))
            sql_query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"

            cursor.execute(sql_query, tuple(entry.values()))
            lex_id = cursor.lastrowid  # Directly capture the lex_id here
            print(f"Inserted entry with lex_id: {lex_id} into {table_name}")

            if lex_id:
                conn.commit()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
            conn.rollback()
        finally:
            conn.close()

        return lex_id  # Return the lex_id



    def get_last_insert_id(self) -> int:
        """
        Get the last inserted ID in the lexicon table.
        """
        conn = self._connect()
        cursor = conn.cursor()
        try:
            cursor.execute("SELECT LAST_INSERT_ID()")
            last_id = cursor.fetchone()[0]
            print(f"Retrieved last insert ID: {last_id}")
        except mysql.connector.Error as err:
            print(f"Error retrieving last insert ID: {err}")
            last_id = None
        finally:
            conn.close()
        return last_id

    def link_entry_with_stix(self, lex_id: int, stix_uuid: str) -> None:
        conn = self._connect()
        cursor = conn.cursor()
        try:
            cursor.execute(
                "INSERT INTO obj_lex_jt (lex_id, obj_id) VALUES (%s, %s)",
                (lex_id, stix_uuid)
            )
            conn.commit()
            print(f"Successfully linked lex_id {lex_id} with stix_uuid {stix_uuid}")
        except mysql.connector.Error as err:
            print(f"Error linking lex_id {lex_id} with stix_uuid {stix_uuid}: {err}")
            conn.rollback()
        finally:
            conn.close()

    def find_entry_by_id(self, tag_form_hash: str) -> Optional[Dict[str, Any]]:
        """
        Find a lexicon entry by its tag form hash.
        """
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM lexicon WHERE tag_form_hash = %s", (tag_form_hash,))
        row = cursor.fetchone()
        conn.close()
        return self._map_row_to_entry(row) if row else None

    def link_existing_entry(self, tag_form_hash: str) -> None:
        """
        Link an existing entry (placeholder method, to be implemented as needed).
        """
        pass

    def find_stix_object_by_id(self, obj_id: str) -> Optional[Dict[str, Any]]:
        """
        Find a STIX object by its ID.
        """
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM stix_objects WHERE obj_id = %s", (obj_id,))
        row = cursor.fetchone()
        conn.close()
        return self._map_row_to_stix_object(row) if row else None

    def save_stix_object(self, stix_object: Dict[str, Any]) -> None:
        """
        Save a STIX object to the database.
        """
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO stix_objects (obj_id, type, created_by_ref, description, spec_version, created, modified, revoked, labels, confidence, lang, external_references, object_marking_refs, granular_markings, extensions, derived_from, duplicate_of, related_to)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                type = VALUES(type),
                created_by_ref = VALUES(created_by_ref),
                description = VALUES(description),
                spec_version = VALUES(spec_version),
                created = VALUES(created),
                modified = VALUES(modified),
                revoked = VALUES(revoked),
                labels = VALUES(labels),
                confidence = VALUES(confidence),
                lang = VALUES(lang),
                external_references = VALUES(external_references),
                object_marking_refs = VALUES(object_marking_refs),
                granular_markings = VALUES(granular_markings),
                extensions = VALUES(extensions),
                derived_from = VALUES(derived_from),
                duplicate_of = VALUES(duplicate_of),
                related_to = VALUES(related_to)
            """,
            (
                stix_object['obj_id'], stix_object['type'], stix_object['created_by_ref'], stix_object['description'],
                stix_object['spec_version'], stix_object['created'], stix_object['modified'], stix_object['revoked'],
                stix_object['labels'], stix_object['confidence'], stix_object['lang'], stix_object['external_references'],
                stix_object['object_marking_refs'], stix_object['granular_markings'], stix_object['extensions'],
                stix_object['derived_from'], stix_object['duplicate_of'], stix_object['related_to']
            )
        )
        conn.commit()
        conn.close()

    def _map_row_to_entry(self, row: Tuple) -> Dict[str, Any]:
        """
        Map a database row to a lexicon entry dictionary.
        """
        if not row:
            return None
        return {
            'lex_id': row[0],
            'word_tag': row[1],
            'word_form': row[2],
            'logical_symbol': row[3],
            'third_arg': row[4],
            'tag_form_hash': row[5],
            'word_def': row[6],
            'synsets': row[7],
            'tagsets': row[8]
        }

    def _map_row_to_stix_object(self, row: Tuple) -> Dict[str, Any]:
        """
        Map a database row to a STIX object dictionary.
        """
        if not row:
            return None
        return {
            'obj_id': row[0], 'type': row[1], 'created_by_ref': row[2], 'description': row[3],
            'spec_version': row[4], 'created': row[5], 'modified': row[6], 'revoked': row[7],
            'labels': row[8], 'confidence': row[9], 'lang': row[10], 'external_references': row[11],
            'object_marking_refs': row[12], 'granular_markings': row[13], 'extensions': row[14],
            'derived_from': row[15], 'duplicate_of': row[16], 'related_to': row[17]
        }
