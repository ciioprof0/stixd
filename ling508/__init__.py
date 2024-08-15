"""This file is used to add the necessary directories to sys.path so that the
modules in the app, db, model, tests, and web directories can be imported"""

import sys
import os

# Append the project root directory to sys.path
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(project_root)

# Append the necessary directories to sys.path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(current_dir, 'app'))
sys.path.append(os.path.join(current_dir, 'data'))
sys.path.append(os.path.join(current_dir, 'db'))
sys.path.append(os.path.join(current_dir, 'demos'))
sys.path.append(os.path.join(current_dir, 'docs'))
sys.path.append(os.path.join(current_dir, 'logs'))
sys.path.append(os.path.join(current_dir, 'model'))
sys.path.append(os.path.join(current_dir, 'tests'))
sys.path.append(os.path.join(current_dir, 'web'))
