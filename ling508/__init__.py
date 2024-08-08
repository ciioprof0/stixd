import sys
import os

# Append the necessary directories to sys.path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(current_dir, 'app'))
sys.path.append(os.path.join(current_dir, 'db'))
sys.path.append(os.path.join(current_dir, 'model'))
sys.path.append(os.path.join(current_dir, 'test'))