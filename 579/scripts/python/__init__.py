"""
Initialization file for the database setup package.
"""

from .setup_database import main as setup_database
from .create_tables import main as create_tables
from .create_procedures import main as create_procedures
from .create_triggers import main as create_triggers
from .seed_tables import main as seed_tables
from .setup_all import main as setup_all

__all__ = [
    "setup_database",
    "create_tables",
    "create_procedures",
    "create_triggers",
    "seed_tables",
    "setup_all"
]