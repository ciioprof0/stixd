from typing import List, Dict
from app.repository import AbstractRepository
from app.doc_manager import DocumentManager

class StixImporter:
    def __init__(self, db_repo: AbstractRepository, doc_manager: DocumentManager):
        self.db_repo = db_repo
        self.doc_manager = doc_manager

    def import_stix_objects(self, json_files: List[str]):
        for file in json_files:
            stix_object = self.read_json(file)
            self.save_to_db(stix_object)

    def save_to_db(self, stix_object: Dict):
        self.db_repo.save_stix_object(stix_object)
        if stix_object['description']:
            doc_id = self.document_manager.create_document(stix_object)
            self.document_manager.link_document(stix_object['obj_id'], doc_id)

    def read_json(self, file: str) -> Dict:
        # Implementation to read JSON file
        pass