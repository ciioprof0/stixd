#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_sent_manager_live.py

import pytest
from unittest.mock import patch, MagicMock
from ling508.app.nlp_processor import NLPProcessor
from ling508.db.mysql_repository import MySQLRepository
from ling508.model.sent_manager import SentenceManager

@pytest.fixture
def sentence_manager():
    with patch('mysql.connector.connect'):
        db_repo = MySQLRepository()
        mock_model = MagicMock()
        mock_config = MagicMock()
        nlp_processor = NLPProcessor(mock_model, mock_config)
        return SentenceManager(db_repo, nlp_processor)

def test_create_sentence(sentence_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    doc_id = 1
    sentence = "This is an example sentence."

    # Mock the create_sentence method
    sentence_manager.create_sentence(doc_id, sentence)
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO sentences (doc_id, sentence_text) VALUES (%s, %s)",
        (doc_id, sentence)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_link_sentence(sentence_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    doc_id = 1
    sent_id = 1

    # Mock the link_sentence method
    sentence_manager.link_sentence(doc_id, sent_id)
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO doc_sent_jt (doc_id, sent_id) VALUES (%s, %s)",
        (doc_id, sent_id)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_process_sentence_text(sentence_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    sent_id = 1
    processed_text = "Processed sentence text"

    # Mock the process_sentence_text method
    with patch.object(sentence_manager.nlp_processor, 'process_text', return_value=processed_text):
        sentence_manager.process_sentence_text(sent_id)
        mock_cursor.execute.assert_called_once_with(
            "UPDATE sentences SET proc_sent = %s WHERE sent_id = %s",
            (processed_text, sent_id)
        )
        mock_conn.return_value.commit.assert_called_once()

    patch.stopall()
