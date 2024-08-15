#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_20_gen_clex_uuid.py

import pytest
# import requests
# import sys
from unittest.mock import patch
# from io import StringIO
from ling508.app.gen_clex_uuid import generate_stix_uuid

# Define test cases
test_cases = [
    (4, "x-stixd-clex", "https://raw.githubusercontent.com/ciioprof0/stixd/03c934281777fecd3edb1d8622310bbf0839c17d/tests/test_clex.pl"),
    (4, "x-stixd-clex", "https://raw.githubusercontent.com/Attempto/Clex/20960a5ce07776cb211a8cfb25dc8c81fcdf25e2/clex_lexicon.pl")
]

# Mock response content
mock_file_contents = {
    "https://raw.githubusercontent.com/ciioprof0/stixd/03c934281777fecd3edb1d8622310bbf0839c17d/tests/test_clex.pl": "mock content for test_clex.pl",
    "https://raw.githubusercontent.com/Attempto/Clex/20960a5ce07776cb211a8cfb25dc8c81fcdf25e2/clex_lexicon.pl": "mock content for Attempto clex_lexicon.pl"
}

# Mock requests.get to return the mocked file content
class MockResponse:
    def __init__(self, url):
        self.url = url
        self.text = mock_file_contents[url]

    def raise_for_status(self):
        pass

@patch('requests.get', side_effect=lambda url: MockResponse(url))
@pytest.mark.parametrize("uuid_version, object_type, file_url", test_cases)
def test_generate_uuid(mock_get, uuid_version, object_type, file_url):
    # Call the generate_stix_uuid function directly
    stix_identifier = generate_stix_uuid(uuid_version, object_type, file_url)

    # Ensure that the identifier starts with the object type and contains a UUID
    assert stix_identifier.startswith(f"{object_type}--")
    assert len(stix_identifier.split("--")[1]) == 36  # UUID length
