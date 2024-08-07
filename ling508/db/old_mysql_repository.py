#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import Any, Dict, List, Optional, Set
import mysql.connector
from ling508.db.old_repository import AbstractRepository
from app.lexicon_manager import Lexeme

class MySQLRepository(AbstractRepository):

    def __init__(self, connection_params):
        self.connection_params = connection_params

    def _connect(self):
        return mysql.connector.connect(**self.connection_params)

    def load_entries(self) -> List[Lexeme]:
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM entries")
        rows = cursor.fetchall()
        conn.close()
        return [self._map_row_to_entry(row) for row in rows]

    def save_entry(self, entry: Lexeme) -> None:
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO entries (base_form, pos, definition, synonyms, antonyms) VALUES (%s, %s, %s, %s, %s)",
            (entry.base_form, entry.pos, entry.definition, ",".join(entry.synonyms), ",".join(entry.antonyms))
        )
        conn.commit()
        conn.close()

    def find_entry_by_id(self, entry_id: int) -> Optional[Lexeme]:
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM entries WHERE id = %s", (entry_id,))
        row = cursor.fetchone()
        conn.close()
        return self._map_row_to_entry(row) if row else None

    def find_stix_object_by_id(self, obj_id: str) -> Optional[Dict]:
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM stix_objects WHERE obj_id = %s", (obj_id,))
        row = cursor.fetchone()
        conn.close()
        return self._map_row_to_stix_object(row) if row else None

    def save_stix_object(self, stix_object: Dict) -> None:
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO stix_objects (obj_id, type, created_by_ref, description, spec_version, created, modified, revoked, labels, confidence, lang, external_references, object_marking_refs, granular_markings, extensions, derived_from, duplicate_of, related_to) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
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

    def _map_row_to_entry(self, row) -> Lexeme:
        if not row:
            return None
        id, base_form, pos, definition, synonyms, antonyms = row
        return Lexeme(
            base_form=base_form,
            pos=pos,
            definition=definition,
            synonyms=set(synonyms.split(",")),
            antonyms=set(antonyms.split(","))
        )

    def _map_row_to_stix_object(self, row) -> Dict:
        if not row:
            return None
        return {
            'obj_id': row[0], 'type': row[1], 'created_by_ref': row[2], 'description': row[3],
            'spec_version': row[4], 'created': row[5], 'modified': row[6], 'revoked': row[7],
            'labels': row[8], 'confidence': row[9], 'lang': row[10], 'external_references': row[11],
            'object_marking_refs': row[12], 'granular_markings': row[13], 'extensions': row[14],
            'derived_from': row[15], 'duplicate_of': row[16], 'related_to': row[17]
        }