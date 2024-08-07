from flask import Flask, request, jsonify
from src.clex_importer import ClexImporter
from src.mysql_repository import MySQLRepository

app = Flask(__name__)

@app.route('/import_clex', methods=['POST'])
def import_clex():
    uri = request.form['uri']
    db_repo = MySQLRepository()
    clex_importer = ClexImporter(db_repo, uri)
    try:
        message = clex_importer.import_clex_entries(uri)
        return jsonify({"message": message})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)