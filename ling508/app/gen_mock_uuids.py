import uuid
import hashlib

STIX_NAMESPACE = uuid.UUID("00abedb4-aa42-466c-9c01-fed23315a9b7")

def generate_expected_uuid_v5(name: str) -> str:
    return str(uuid.uuid5(STIX_NAMESPACE, name))

# Mock file contents
mock_file_contents = {
    "https://raw.githubusercontent.com/ciioprof0/stixd/03c934281777fecd3edb1d8622310bbf0839c17d/tests/test_clex.pl": "mock content for test_clex.pl",
    "https://raw.githubusercontent.com/Attempto/Clex/20960a5ce07776cb211a8cfb25dc8c81fcdf25e2/clex_lexicon.pl": "mock content for Attempto clex_lexicon.pl"
}

# Generate expected UUIDs
expected_uuid1 = generate_expected_uuid_v5(mock_file_contents["https://raw.githubusercontent.com/ciioprof0/stixd/03c934281777fecd3edb1d8622310bbf0839c17d/tests/test_clex.pl"])
expected_uuid2 = generate_expected_uuid_v5(mock_file_contents["https://raw.githubusercontent.com/Attempto/Clex/20960a5ce07776cb211a8cfb25dc8c81fcdf25e2/clex_lexicon.pl"])

print(f"Expected UUID for test_clex.pl: {expected_uuid1}")
print(f"Expected UUID for clex_lexicon.pl: {expected_uuid2}")
