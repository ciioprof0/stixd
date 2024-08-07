from abc import ABC, abstractmethod
from typing import List, Dict, Any, Optional

class AbstractRepository(ABC):

    @abstractmethod
    def load_entries(self) -> List[Any]:
        pass

    @abstractmethod
    def save_entry(self, entry: Any) -> None:
        pass

    @abstractmethod
    def find_entry_by_id(self, entry_id: int) -> Optional[Any]:
        pass

    @abstractmethod
    def find_stix_object_by_id(self, obj_id: str) -> Optional[Any]:
        pass

    @abstractmethod
    def save_stix_object(self, stix_object: Dict) -> None:
        pass