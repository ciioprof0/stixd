#!/usr/bin/env python
# -*- coding: utf-8 -*-
# api.py

""" This module contains the API for the Ling 508 project. """

import logging  # Log unexpected errors
import os  # Create directories for logs
import sys  # Add the project directory to the path
from flask import Flask, request, jsonify # Create the API
from requests.exceptions import RequestException  # Catch HTTP request errors
from pymysql import MySQLError  # Catch specific MySQL errors
from werkzeug.exceptions import BadRequest  # Catch Flask request errors

# Set the path only if not already set
if 'stixd' not in sys.path:
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    sys.path.append(project_root)
    sys.path.append(os.path.join(project_root, 'ling508'))
    sys.path.append(os.path.join(project_root, 'ling508', 'app'))
    sys.path.append(os.path.join(project_root, 'ling508', 'db'))
    sys.path.append(os.path.join(project_root, 'ling508', 'demos'))
    sys.path.append(os.path.join(project_root, 'ling508', 'models'))
    sys.path.append(os.path.join(project_root, 'ling508', 'tests'))

# Import Local Modules
from ling508.app.clex_importer import ClexImporter # Import Clex entries
from ling508.db.mysql_repository import MySQLRepository # Access the MySQL db


# Setup logging
LOG_DIR = "logs"
if not os.path.exists(LOG_DIR):
    os.makedirs(LOG_DIR)

logging.basicConfig(
    filename=os.path.join(LOG_DIR, 'api.log'),
    level=logging.ERROR,  # Log only errors and critical issues
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

app = Flask(__name__, static_folder='D:/OneDrive/Code/hltms/stixd/ling508/web')

@app.route('/')
def serve_form():
    """Serves the form for importing Clex entries."""
    return app.send_static_file('stixd.html')


@app.route('/import_clex', methods=['POST'])
def import_clex():
    """Imports Clex entries from a URI."""
    uri = request.form.get('uri')  # Safely get 'uri' from form data

    if not uri:
        response = {"error": "URI is required"}
        logging.error("Bad request: URI is missing")
        return jsonify(response), 400

    db_repo = MySQLRepository()
    clex_importer = ClexImporter(db_repo, uri)

    try:
        message = clex_importer.import_clex_entries(uri)
        return jsonify({"message": message}), 200
    except BadRequest as br:
        logging.error("Bad request: %s", br)
        return jsonify({"error": f"Bad request: {str(br)}"}), 400
    except RequestException as re:
        logging.error("URI request failed: %s", re)
        return jsonify({"error": f"URI request failed: {str(re)}"}), 400
    except MySQLError as mse:
        logging.error("MySQL error: %s", mse)
        return jsonify({"error": f"MySQL error: {str(mse)}"}), 500
    except ValueError as ve:
        logging.error("Invalid input: %s", ve)
        return jsonify({"error": f"Invalid input: {str(ve)}"}), 400
    except OSError as oe:
        logging.error("System error: %s", oe)
        return jsonify({"error": f"System error: {str(oe)}"}), 500
    except Exception as e:
        logging.error("An unexpected error occurred: %s", e)
        return jsonify({"error": f"An unexpected error occurred: {str(e)}"}), 500

if __name__ == "__main__":
    app.run(debug=True)
