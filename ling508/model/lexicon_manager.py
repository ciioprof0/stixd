#!/usr/bin/env python
# -*- coding: utf-8 -*-
# model/lexicon_manager.py

from ling508.app.nlp_processor import NLPProcessor
from ling508.db.mysql_repository import MySQLRepository

class LexiconManager:
    def __init__(self, db_repo: MySQLRepository, nlp_processor: NLPProcessor):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_lexicon_entry(self, sent_id: int, word: str) -> int:
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO lexicon (sent_id, word) VALUES (%s, %s)",
            (sent_id, word)
        )
        lex_id = cursor.lastrowid
        conn.commit()
        conn.close()
        return lex_id

    def link_lexicon_entry(self, sent_id: int, lex_id: int):
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO sent_lex_jt (sent_id, lex_id) VALUES (%s, %s)",
            (sent_id, lex_id)
        )
        conn.commit()
        conn.close()

    def process_word(self, word: str):
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        processed_word = self.nlp_processor.process_text(word)
        cursor.execute(
            "UPDATE lexicon SET proc_word = %s WHERE word = %s",
            (processed_word, word)
        )
        conn.commit()
        conn.close()

if __name__ == "__main__":
    db_repo = MySQLRepository()
    nlp_processor = NLPProcessor()
    lexicon_manager = LexiconManager(db_repo, nlp_processor)
