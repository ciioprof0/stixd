from src.repository import AbstractRepository
from src.nlp_processor import NLPProcessor
from src.mysql_repository import MySQLRepository

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

if __name__ == "__main__":
    db_repo = MySQLRepository()
    nlp_processor = NLPProcessor()
    lexicon_manager = LexiconManager(db_repo, nlp_processor)
    # Example usage
    # sent_id = 1  # Replace with actual sent_id
    # word = "example"
    # lex_id = lexicon_manager.create_lexicon_entry(sent_id, word)
    # lexicon_manager.link_lexicon_entry(sent_id, lex_id)
    # lexicon_manager.process_word(word)
