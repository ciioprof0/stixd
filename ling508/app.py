from flask import Flask, request, jsonify
from src.clex_importer import ClexImporter
from src.mysql_repository import MySQLRepository

app = Flask(__name__)

DB_CONNECTION_PARAMS = {
    'host': 'localhost',
    'user': 'your_username',
    'password': 'your_password',
    'database': 'stixd_corpus'
}

@app.route('/import_clex', methods=['POST'])
def import_clex():
    uri = request.form['uri']
    db_repo = MySQLRepository(DB_CONNECTION_PARAMS)
    clex_importer = ClexImporter(db_repo, uri)
    try:
        clex_importer.import_clex_entries(uri)
        return jsonify({"message": "Clex entries imported successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
