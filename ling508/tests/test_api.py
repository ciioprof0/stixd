#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_api.py

from unittest.mock import patch
import pytest
from ling508.api import app

@pytest.fixture
def test_client():
    """Fixture to create a test client for the Flask app."""
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

@patch('ling508.api.ClexImporter')
@patch('ling508.api.MySQLRepository')
def test_import_clex_success(mock_mysql_repo, mock_clex_importer, test_client):
    """Test successful import of Clex entries."""
    mock_clex_importer_instance = mock_clex_importer.return_value
    mock_clex_importer_instance.import_clex_entries.return_value = "Import successful"

    response = test_client.post('/import_clex', data={'uri': 'http://test-uri'})

    assert response.status_code == 200
    assert response.json == {"message": "Import successful"}
    mock_clex_importer_instance.import_clex_entries.assert_called_once_with('http://test-uri')

@patch('ling508.api.ClexImporter')
def test_import_clex_bad_request(mock_clex_importer, test_client):
    """Test handling of a bad request exception."""
    response = test_client.post('/import_clex', data={'uri': ''})

    assert response.status_code == 400
    assert "error" in response.json

@patch('ling508.api.ClexImporter')
def test_import_clex_request_exception(mock_clex_importer, test_client):
    """Test handling of a request exception."""
    mock_clex_importer_instance = mock_clex_importer.return_value
    mock_clex_importer_instance.import_clex_entries.side_effect = Exception("URI request failed")

    response = test_client.post('/import_clex', data={'uri': 'http://invalid-uri'})

    assert response.status_code == 500
    assert response.json["error"] == "An unexpected error occurred: URI request failed"

@patch('ling508.api.ClexImporter')
def test_import_clex_mysql_error(mock_clex_importer, test_client):
    """Test handling of a MySQL error."""
    mock_clex_importer_instance = mock_clex_importer.return_value
    mock_clex_importer_instance.import_clex_entries.side_effect = Exception("MySQL error")

    response = test_client.post('/import_clex', data={'uri': 'http://test-uri'})

    assert response.status_code == 500
    assert response.json["error"] == "An unexpected error occurred: MySQL error"

@patch('ling508.api.ClexImporter')
def test_import_clex_system_error(mock_clex_importer, test_client):
    """Test handling of a system error."""
    mock_clex_importer_instance = mock_clex_importer.return_value
    mock_clex_importer_instance.import_clex_entries.side_effect = OSError("System error")

    response = test_client.post('/import_clex', data={'uri': 'http://test-uri'})

    assert response.status_code == 500
    assert response.json["error"] == "System error: System error"
