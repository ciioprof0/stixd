from app.repository import AbstractRepository
from app.nlp_processor import NLPProcessor

class LexiconManager:
    def __init__(self, db_repo: AbstractRepository, nlp_processor: NLPProcessor):
        self.db_repo = db_repo
        self.nlp_processor = nlp_processor

    def create_lexicon_entry(self, sent_id: int, word: str) -> int:
        # Implementation to create a lexicon entry
        pass

    def link_lexicon_entry(self, sent_id: int, lex_id: int):
        # Implementation to link lexicon entry in sent_lex_jt
        pass

    def process_word(self, word: str):
        # Implementation to process word
        pass
