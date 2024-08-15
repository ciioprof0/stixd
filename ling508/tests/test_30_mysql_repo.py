#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_30_mysql_repo.py

import pytest
from unittest.mock import patch, MagicMock
from ling508.db.mysql_repository import MySQLRepository

@pytest.fixture
def repository():
    with patch('mysql.connector.connect'):
        return MySQLRepository()

def test_save_and_load_entry(repository):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    entry = {
        'word_tag': 'test',
        'word_form': 'noun',
        'tag_form_hash': 'test_hash',
        'logical_symbol': 'test_symbol',
        'third_arg': 'test_arg'
    }

    # Mock the save_entry method
    repository.save_entry(entry)
    mock_cursor.execute.assert_called_once_with(
        "INSERT INTO lexicon (word_tag, word_form, tag_form_hash, logical_symbol, third_arg) VALUES (%s, %s, %s, %s, %s)",
        (entry['word_tag'], entry['word_form'], entry['tag_form_hash'], entry['logical_symbol'], entry['third_arg'])
    )
    mock_conn.return_value.commit.assert_called_once()

    # Mock the load_entries method
    mock_cursor.fetchall.return_value = [
        (1, 'test', 'noun', 'test_symbol', 'test_arg', 'test_hash', 'test_def', 'test_synsets', 'test_tagsets')
    ]
    entries = repository.load_entries()
    assert len(entries) == 1
    assert entries[0]['word_tag'] == 'test'

    patch.stopall()

def test_find_entry_by_id(repository):
    mock_conn = patch('mysql.connector.connect').start()
    mock_cursor = MagicMock()
    mock_conn.return_value.cursor.return_value = mock_cursor

    # Mock the find_entry_by_id method
    tag_form_hash = 'test_hash'
    mock_cursor.fetchone.return_value = (1, 'example', 'noun', 'example_symbol', 'example_arg', tag_form_hash, 'example_def', 'example_synsets', 'example_tagsets')
    entry = repository.find_entry_by_id(tag_form_hash)
    assert entry is not None
    assert entry['word_tag'] == 'example'

    patch.stopall()