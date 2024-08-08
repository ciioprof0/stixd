#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_nlp_processor.py

import pytest
from unittest.mock import patch, MagicMock
from ling508.model.nlp_manager import NLPManager

@pytest.fixture
def nlp_processor():
    mock_model = MagicMock()
    mock_config = MagicMock()
    return NLPManager(mock_model, mock_config)

def test_process_text(nlp_processor):
    text = "This is a test text."
    processed_text = "Processed text content"
    metadata = {"key": "value"}

    # Mock the process_text method
    with patch.object(nlp_processor, 'process_text', return_value=(processed_text, metadata)):
        result_text, result_metadata = nlp_processor.process_text(text)
        assert result_text == processed_text
        assert result_metadata == metadata

def test_process_sentence(nlp_processor):
    sentence = "This is a test sentence."
    processed_data = {"processed": "data"}

    # Mock the process_sentence method
    with patch.object(nlp_processor, 'process_sentence', return_value=processed_data):
        result_data = nlp_processor.process_sentence(sentence)
        assert result_data == processed_data
