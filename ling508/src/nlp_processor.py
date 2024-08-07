from typing import Tuple, Dict

class NLPProcessor:
    def __init__(self, model, config):
        self.model = model
        self.config = config

    def process_text(self, text: str) -> Tuple[str, Dict]:
        # Implementation to process text and return processed text and metadata
        pass

    def process_sentence(self, sentence: str) -> Dict:
        # Implementation to process sentence and return processed data
        pass