#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_50_doc_manager.py

import pytest
from unittest.mock import patch, MagicMock
from ling508.model.nlp_manager import NLPManager
from ling508.db.mysql_repository import MySQLRepository
from ling508.model.doc_manager import DocumentManager

@pytest.fixture
def document_manager():
    with patch('mysql.connector.connect'):
        db_repo = MySQLRepository()
        mock_model = MagicMock()
        mock_config = MagicMock()
        nlp_processor = NLPManager(mock_model, mock_config)
        return DocumentManager(db_repo, nlp_processor)

def test_create_document(document_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    stix_object = {
        "obj_id": "example-stix-id",
        "description": "Example STIX object"
    }

    print("Calling create_document...")
    document_manager.create_document(stix_object)

    print("Checking if execute was called...")
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO documents (obj_id, description) VALUES (%s, %s)",
        (stix_object['obj_id'], stix_object['description'])
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_link_document(document_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    stix_id = "example-stix-id"
    doc_id = 1

    print("Calling link_document...")
    document_manager.link_document(stix_id, doc_id)

    print("Checking if execute was called...")
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO obj_doc_jt (obj_id, doc_id) VALUES (%s, %s)",
        (stix_id, doc_id)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_process_document_text(document_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    doc_id = 1
    processed_text = "Processed text content"
    metadata = "Metadata information"

    print("Calling process_document_text...")
    with patch.object(document_manager.nlp_processor, 'process_text', return_value=(processed_text, metadata)):
        document_manager.process_document_text(doc_id)

    print("Checking if execute was called...")
    mock_cursor.execute.assert_called_once_with(
        "UPDATE documents SET proc_text = %s, metadata = %s WHERE doc_id = %s",
        (processed_text, metadata, doc_id)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()
