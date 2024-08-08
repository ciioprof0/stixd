#!/usr/bin/env python
# -*- coding: utf-8 -*-
# model/sent_manager.py

from app.nlp_processor import NLPProcessor
from db.mysql_repository import MySQLRepository
from db.repository import AbstractRepository

class SentenceManager:
    def __init__(self, db_repo: AbstractRepository, nlp_processor: NLPProcessor):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_sentence(self, doc_id: int, sentence: str) -> int:
        # Implementation to create a sentence
        pass

    def link_sentence(self, doc_id: int, sent_id: int):
        # Implementation to link sentence in doc_sent_jt
        pass

    def process_sentence_text(self, sent_id: int):
        # Implementation to process sentence text and update proc_sent
        pass

if __name__ == "__main__":
    db_repo = MySQLRepository()
    nlp_processor = NLPProcessor()
    sentence_manager = SentenceManager(db_repo, nlp_processor)
    # Example usage
    # doc_id = 1  # Replace with actual doc_id
    # sentence = "This is an example sentence."
    # sent_id = sentence_manager.create_sentence(doc_id, sentence)
    # sentence_manager.link_sentence(doc_id, sent_id)
    # sentence_manager.process_sentence_text(sent_id)
