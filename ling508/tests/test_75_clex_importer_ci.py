#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_75_clex_importer_cik.py

"""Unit tests for the ClexImporter class in the clex_importer module."""

from unittest.mock import MagicMock, patch
import pytest
from ling508.app.clex_importer import ClexImporter
from ling508.db.mysql_repository import MySQLRepository

@pytest.fixture
def mock_db_repo():
    """Fixture to create a mock MySQLRepository instance."""
    return MagicMock(spec=MySQLRepository)

@pytest.fixture
def clex_importer(mock_db_repo):
    """Fixture to create a ClexImporter instance with a mock MySQLRepository."""
    return ClexImporter(mock_db_repo, "lexicon/test_clex.pl")

@patch('ling508.app.clex_importer.requests.get')
@patch('ling508.app.clex_importer.generate_stix_uuid')
def test_import_clex_entries(mock_generate_stix_uuid, mock_requests_get,
                             clex_importer, mock_db_repo):
    """Test the import_clex_entries function."""
    # Mock the requests.get response
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.text = """
    noun('dog', dog).
    verb('run', run, sing).
    adjective('happy', happy).
    """
    mock_requests_get.return_value = mock_response

    # Mock the generate_stix_uuid function
    mock_generate_stix_uuid.return_value = "test-uuid"

    # Mock the database repository methods
    mock_db_repo.find_entry_by_id.return_value = None
    mock_db_repo.get_last_insert_id.return_value = 1

    # Call the import_clex_entries function
    result = clex_importer.import_clex_entries("http://test-uri")

    # Assertions
    assert result == "Import successful"
    mock_requests_get.assert_called_once_with("http://test-uri", timeout=20)
    mock_generate_stix_uuid.assert_called_once_with(4, "x-stixd-clex", "http://test-uri")
    assert mock_db_repo.save_stix_object.called
    assert mock_db_repo.save_entry.call_count == 3
    assert mock_db_repo.link_entry_with_stix.call_count == 3
