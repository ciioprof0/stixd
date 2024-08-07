from typing import Dict
from app.repository import AbstractRepository
from app.nlp_processor import NLPProcessor

class DocumentManager:
    def __init__(self, db_repo: AbstractRepository, nlp_processor: NLPProcessor):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_document(self, stix_object: Dict) -> int:
        # Implementation to create a document
        pass

    def link_document(self, stix_id: str, doc_id: int):
        # Implementation to link document in obj_doc_jt
        pass

    def process_document_text(self, doc_id: int):
        # Implementation to process document text and update proc_text, metadata
        pass