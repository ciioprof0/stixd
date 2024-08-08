#!/usr/bin/env python
# -*- coding: utf-8 -*-
# test/test_lexicon_manager_live.py

import pytest
from unittest.mock import patch, MagicMock
from db.mysql_repository import MySQLRepository
from model.lexicon_manager import LexiconManager
from app.nlp_processor import NLPProcessor

@pytest.fixture
def lexicon_manager():
    with patch('mysql.connector.connect'):
        db_repo = MySQLRepository()
        nlp_processor = NLPProcessor()
        return LexiconManager(db_repo, nlp_processor)

def test_create_lexicon_entry(lexicon_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    sent_id = 1
    word = "example"

    # Mock the create_lexicon_entry method
    lexicon_manager.create_lexicon_entry(sent_id, word)
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO lexicon (sent_id, word) VALUES (%s, %s)",
        (sent_id, word)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_link_lexicon_entry(lexicon_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    sent_id = 1
    lex_id = 1

    # Mock the link_lexicon_entry method
    lexicon_manager.link_lexicon_entry(sent_id, lex_id)
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO sent_lex_jt (sent_id, lex_id) VALUES (%s, %s)",
        (sent_id, lex_id)
    )
    mock_conn.return_value.commit.assert_called_once()

    patch.stopall()

def test_process_word(lexicon_manager):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    word = "example"
    processed_word = "Processed example"

    # Mock the process_word method
    with patch.object(lexicon_manager.nlp_processor, 'process_text', return_value=processed_word):
        lexicon_manager.process_word(word)
        mock_cursor.execute.assert_called_once_with(
            "UPDATE lexicon SET proc_word = %s WHERE word = %s",
            (processed_word, word)
        )
        mock_conn.return_value.commit.assert_called_once()

    patch.stopall()
