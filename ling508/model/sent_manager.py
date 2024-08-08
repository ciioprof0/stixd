#!/usr/bin/env python
# -*- coding: utf-8 -*-
# model/sent_manager.py

from ling508.model.nlp_manager import NLPManager
from ling508.db.mysql_repository import MySQLRepository

class SentenceManager:
    def __init__(self, db_repo: MySQLRepository, nlp_processor: NLPManager):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_sentence(self, doc_id: int, sentence: str) -> int:
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO sentences (doc_id, sentence_text) VALUES (%s, %s)",
            (doc_id, sentence)
        )
        sent_id = cursor.lastrowid
        conn.commit()
        conn.close()
        return sent_id

    def link_sentence(self, doc_id: int, sent_id: int):
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO doc_sent_jt (doc_id, sent_id) VALUES (%s, %s)",
            (doc_id, sent_id)
        )
        conn.commit()
        conn.close()

    def process_sentence_text(self, sent_id: int):
        conn = self.db_repo._connect()
        cursor = conn.cursor()
        processed_text = self.nlp_processor.process_text("dummy sentence")  # Replace with actual sentence fetching logic
        cursor.execute(
            "UPDATE sentences SET proc_sent = %s WHERE sent_id = %s",
            (processed_text, sent_id)
        )
        conn.commit()
        conn.close()

if __name__ == "__main__":
    db_repo = MySQLRepository()
    nlp_processor = NLPManager()
    sentence_manager = SentenceManager(db_repo, nlp_processor)
