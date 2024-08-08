#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/stix_importer.py

from typing import List, Dict
from db.mysql_repository import MySQLRepository
from db.repository import AbstractRepository
from model.doc_manager import DocumentManager

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
            doc_id = self.doc_manager.create_document(stix_object)
            self.doc_manager.link_document(stix_object['obj_id'], doc_id)

    def read_json(self, file: str) -> Dict:
        # Implementation to read JSON file
        pass

if __name__ == "__main__":
    db_repo = MySQLRepository()
    doc_manager = DocumentManager()
    stix_importer = StixImporter(db_repo, doc_manager)
    # Add the list of JSON files to be imported
    json_files = ["path/to/stix_file1.json", "path/to/stix_file2.json"]
    stix_importer.import_stix_objects(json_files)
