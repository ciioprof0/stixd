### LING 508: STIX-D Lexicon Importer

#### Overview
This module focuses on developing an application to extract descriptions from STIX objects, parsing the description texts into documents, sentences, and words to form a comprehensive corpus. The project aligns with the Controlled Natural Language (CNL) development for Structured Threat Information eXpression (STIX) within the Cyber Threat Intelligence (CTI) domain.

#### Functional Components

##### Clex Importer
`clex_importer.py` handles importing the ACE Common Lexicon (Clex) into the STIX-D Corpus Database, parsing the content, and saving lexical entries into the database.

##### Lexicon Manager
`lexicon_manager.py` manages the processing of lexical entries and creation of lexicon objects in the database.

##### Sentence Manager
`sent_manager.py` manages the processing of sentences and creation of sentence objects in the database.

##### Document Scraper
`doc_scrapper.py` manages fetching and processing HTML documents, converting them to markdown.

##### Document Manager
`doc_manager.py` manages the processing of documents and creation of document objects in the database.

##### STIX Importer
`stix_importer.py` handles importing STIX objects into the STIX-D Corpus Database, parsing the content, and saving descriptions into the database.

##### MySQL Repository
`mysql_repository.py` provides the MySQL database implementation for Create, Read, Update, and Delete (CRUD) operations in the repository.

##### Repository Abstraction
`repository.py` defines the abstract repository interface, and mysql_repository.py provides the MySQL database implementation for CRUD operations.

##### UUID Generation
`gen_uuid.py` and `gen_clex_uuid.py` handle generating UUIDs for STIX objects and Clex entries, respectively.

##### NLP Manager
`nlp_manager.py` will contain functions for processing natural language text for CNL development.

#### Testing
Unit tests are located in the `tests` directory, utilizing `pytest` to ensure the functionality of various components.

#### Flask API
`app.py` contains a simple Flask API for interacting with the STIX-D Corpus Database.