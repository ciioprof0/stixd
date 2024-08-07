from abc import ABC, abstractmethod
from typing import List, Dict, Any, Optional, Tuple

class AbstractRepository(ABC):

    @abstractmethod
    def load_entries(self) -> List[Dict[str, Any]]:
        """Load all entries from the database."""
        pass

    @abstractmethod
    def save_entry(self, entry: Dict[str, Any]) -> None:
        """Save a new entry to the database."""
        pass

    @abstractmethod
    def get_last_insert_id(self) -> int:
        """Get the ID of the last inserted entry."""
        pass

    @abstractmethod
    def link_entry_with_stix(self, lex_id: int, stix_uuid: str) -> None:
        """Link an entry with a STIX object."""
        pass

    @abstractmethod
    def find_entry_by_id(self, tag_form_hash: str) -> Optional[Dict[str, Any]]:
        """Find an entry by its hash."""
        pass

    @abstractmethod
    def link_existing_entry(self, tag_form_hash: str) -> None:
        """Link an existing entry if needed."""
        pass

    @abstractmethod
    def find_stix_object_by_id(self, obj_id: str) -> Optional[Dict[str, Any]]:
        """Find a STIX object by its ID."""
        pass

    @abstractmethod
    def save_stix_object(self, stix_object: Dict[str, Any]) -> None:
        """Save a STIX object to the database."""
        pass

    @abstractmethod
    def _map_row_to_entry(self, row: Tuple) -> Dict[str, Any]:
        """Map a database row to a dictionary entry."""
        pass

    @abstractmethod
    def _map_row_to_stix_object(self, row: Tuple) -> Dict[str, Any]:
        """Map a database row to a STIX object dictionary."""
        pass
