# model/doc_manager.py

from ling508.app.nlp_processor import NLPProcessor
from ling508.db.mysql_repository import MySQLRepository
# from ling508.db.repository import AbstractRepository
from typing import Dict

class DocumentManager:
    def __init__(self, db_repo: MySQLRepository, nlp_processor: NLPProcessor):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_document(self, stix_object: Dict) -> int:
        conn = self.db_repo._connect()  # Use MySQLRepository to connect to the DB
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO documents (obj_id, description) VALUES (%s, %s)",
            (stix_object['obj_id'], stix_object['description'])
        )
        doc_id = cursor.lastrowid
        conn.commit()
        conn.close()
        return doc_id

    def link_document(self, stix_id: str, doc_id: int):
        conn = self.db_repo._connect()  # Use MySQLRepository to connect to the DB
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO obj_doc_jt (obj_id, doc_id) VALUES (%s, %s)",
            (stix_id, doc_id)
        )
        conn.commit()
        conn.close()

    def process_document_text(self, doc_id: int):
        conn = self.db_repo._connect()  # Use MySQLRepository to connect to the DB
        cursor = conn.cursor()

        # Assuming process_text is implemented in NLPProcessor and returns processed text and metadata
        processed_text, metadata = self.nlp_processor.process_text("dummy text")  # Replace with actual text fetching logic
        cursor.execute(
            "UPDATE documents SET proc_text = %s, metadata = %s WHERE doc_id = %s",
            (processed_text, metadata, doc_id)
        )
        conn.commit()
        conn.close()
