import pytest
import csv
from unittest.mock import patch

# Load mock data from CSV file
def load_mock_data():
    mock_data = {}
    with open('../lexicon/test_clex_importer.csv', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            lex_id = int(row['lex_id'])
            mock_data[lex_id] = (
                lex_id,
                row['word_tag'],
                row['word_form'],
                row['logical_symbol'],
                None if row['third_arg'] == 'NULL' else row['third_arg'],
                row['tag_form_hash']
            )
    return mock_data

mock_data = load_mock_data()

# Mock function to replace get_lexicon_entry
def mock_get_lexicon_entry(lex_id):
    return mock_data.get(lex_id, None)

# Apply the mock
@pytest.mark.parametrize("lex_id, word_tag, word_form, logical_symbol, third_arg, tag_form_hash", [
    (1, 'adv', 'fast', 'fast', None, '67e9b1c5cbd53045919deda792be49b18b41a09b3bd328f9cc406bb27d951f62'),
    (19, 'noun_pl', 'months', 'month', 'neutr', '6e7ab17fe3f242d10f360197f40646b443db6079d730e9d746c96824a2606336'),
    (39, 'iv_finsg', 'walks', 'walk', None, 'f02be7a15dcd7cca79dc9b1c141991d479120352658c50030c7268da9372e6ff'),
    (58, 'dv_pp', 'succeeded', 'succeed', 'as', '8ee745975fad537905042b710e2f602f6c6bbe6c72f123b3596ce0b962f2b23f')
])
@patch('test_clex_importer.get_lexicon_entry', side_effect=mock_get_lexicon_entry)
def test_lexicon_entry(mock_get, lex_id, word_tag, word_form, logical_symbol, third_arg, tag_form_hash):
    entry = mock_get(lex_id)
    assert entry is not None, f"Entry with lex_id {lex_id} not found"

    db_lex_id, db_word_tag, db_word_form, db_logical_symbol, db_third_arg, db_tag_form_hash = entry

    assert db_lex_id == lex_id
    assert db_word_tag == word_tag
    assert db_word_form == word_form
    assert db_logical_symbol == logical_symbol

    if third_arg is None:
        assert db_third_arg is None or db_third_arg == 'NULL'
    else:
        assert db_third_arg == third_arg

    assert db_tag_form_hash == tag_form_hash
