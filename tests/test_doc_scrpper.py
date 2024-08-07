#!/usr/bin/env python
# -*- coding: utf-8 -*-

# tests/test_doc_scrapper.py

import pytest
import requests
from bs4 import BeautifulSoup
from unittest.mock import patch, mock_open
from app.doc_scrapper import allows_scraping, convert_html_to_markdown, fetch_html, process_url, save_markdown

# Mock HTML content for testing
HTML_CONTENT = '''
<html>
<head>
    <title>Test Page</title>
    <meta name="robots" content="noindex">
</head>
<body>
    <p>This is a test page.</p>
</body>
</html>
'''

ALLOWED_HTML_CONTENT = '''
<html>
<head>
    <title>Allowed Test Page</title>
</head>
<body>
    <p>This is an allowed test page.</p>
</body>
</html>
'''

@pytest.fixture
def html_content():
    return HTML_CONTENT

@pytest.fixture
def allowed_html_content():
    return ALLOWED_HTML_CONTENT

def test_fetch_html(monkeypatch, html_content):
    # Mock the requests.get call to return a response with the mock HTML content
    class MockResponse:
        @staticmethod
        def raise_for_status():
            pass

        @property
        def text(self):
            return html_content

    monkeypatch.setattr(requests, 'get', lambda url: MockResponse())

    url = 'https://casl.website'
    html = fetch_html(url)
    assert html == html_content

def test_allows_scraping(html_content, allowed_html_content):
    soup_noindex = BeautifulSoup(html_content, 'html.parser')
    assert not allows_scraping(str(soup_noindex))

    soup_allowed = BeautifulSoup(allowed_html_content, 'html.parser')
    assert allows_scraping(str(soup_allowed))

def test_convert_html_to_markdown(html_content):
    markdown = convert_html_to_markdown(html_content)
    assert 'This is a test page.' in markdown

@patch("builtins.open", new_callable=mock_open)
def test_save_markdown(mock_file):
    markdown_text = "This is a test page."
    title = "Test Page"
    save_path = "docs/test"

    filename = save_markdown(markdown_text, title, save_path)

    # Verify the correct file path and content
    mock_file.assert_called_with("docs/test/Test Page.md", 'w', encoding='utf-8')
    mock_file().write.assert_called_once_with(markdown_text)
    assert filename == "docs/test/Test Page.md"

@patch("builtins.open", new_callable=mock_open)
@patch("requests.get")
def test_process_url(mock_get, mock_file, allowed_html_content):
    class MockResponse:
        @staticmethod
        def raise_for_status():
            pass

        @property
        def text(self):
            return allowed_html_content

    mock_get.return_value = MockResponse()
    url = 'https://casl.website'
    save_path = "docs/test"

    process_url(url, save_path)

    # Verify the file was saved correctly
    mock_file.assert_called_with("docs/test/Allowed Test Page.md", 'w', encoding='utf-8')
    mock_file().write.assert_called_once()