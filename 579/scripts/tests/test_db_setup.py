import pytest
import pymysql

# Database credentials
DB_USER = "your_username"
DB_PASSWORD = "your_password"
DB_NAME = "stixd_corpus"

@pytest.fixture(scope='module')
def db_connection():
    connection = pymysql.connect(
        host='localhost',
        user=DB_USER,
        password=DB_PASSWORD,
        db=DB_NAME,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    yield connection
    connection.close()

def test_database_exists(db_connection):
    with db_connection.cursor() as cursor:
        cursor.execute("SHOW DATABASES LIKE %s", (DB_NAME,))
        result = cursor.fetchone()
        assert result is not None, f"Database {DB_NAME} does not exist."

def test_tables_exist(db_connection):
    tables = [
        "genders", "special_chars", "prohibited_words", "prohibited_intersections",
        "prolog_constraints", "stix_objects", "documents", "sentences",
        "validation_results", "lexicon", "obj_doc_jt", "doc_sent_jt",
        "doc_lex_jt", "sent_lex_jt", "obj_lex_jt"
    ]
    with db_connection.cursor() as cursor:
        for table in tables:
            cursor.execute(f"SHOW TABLES LIKE '{table}'")
            result = cursor.fetchone()
            assert result is not None, f"Table {table} does not exist."

def test_prohibited_words_seeding(db_connection):
    with db_connection.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) as count FROM prohibited_words")
        result = cursor.fetchone()
        assert result['count'] > 0, "No data found in prohibited_words table."

# Add more tests for procedures, triggers, and other seeded data as needed.
