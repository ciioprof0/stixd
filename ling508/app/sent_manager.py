from repository import AbstractRepository
from nlp_processor import NLPProcessor

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