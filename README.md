# STIX Descriptions CNL Repository

For my capstone project in the [HLTMS](https://linguistics.arizona.edu/online-ms-hlt) program, I aim to develop a Controlled Natural Language ([CNL](https://en.wikipedia.org/wiki/Controlled_natural_language)) and necessary tools and databases for Structured Threat Information eXpression  ([STIX](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html)) descriptions in Cyber Threat Intelligence ([CTI](https://www.crowdstrike.com/cybersecurity-101/threat-intelligence/)). The project, named ‘STIX-D’, will be a subset of Attempto Controlled English ([ACE](http://attempto.ifi.uzh.ch/)).

## Phase 1: Build a STIX-D Corpus

Phase 1 of the project started during the Summer 2024 academic session. It includes three components with each component corresponding to a class project. The components are:

- [LING 508](https://catalog.arizona.edu/courses/0198961). An application to extract descriptions from STIX objects and parse the description texts into documents, sentences, and words, forming a corpus.
- [INFO 579](https://catalog.arizona.edu/courses/0424311). A relational database to hold the STIX-D Corpus.
- [INFO 523](https://catalog.arizona.edu/courses/0399651). A natural language processing ([NLP](https://en.wikipedia.org/wiki/Natural_language_processing)) pipeline for CNL development.

### LING 508: STIX-D Lexicon Importer

#### Overview
This module focuses on developing an application to extract descriptions from STIX objects, parsing the description texts into documents, sentences, and words to form a comprehensive corpus. The project aligns with the Controlled Natural Language (CNL) development for Structured Threat Information eXpression (STIX) within the Cyber Threat Intelligence (CTI) domain.

#### Directory Structure
LING508
│
├── docs
│   └── documentation.md
│
├── src
│   ├── __init__.py
│   ├── clex_importer.py
│   ├── doc_manager.py
│   ├── doc_scrapper.py
│   ├── gen_clex_uuid.py
│   ├── gen_uuid.py
│   ├── lexicon_manager.py
│   ├── mysql_repository.py
│   ├── nlp_processor.py
│   ├── repository.py
│   ├── sent_manager.py
│   └── stix_importer.py
│
├── tests
│   ├── __init__.py
│   ├── test_clex_importer_live.py
│   ├── test_clex_importer_mock.py
│   ├── test_doc_scrapper.py
│   └── test_gen_clex_uuid.py
│
├── app.py
├── form.html
└── README.md

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

##### NLP Processor
`nlp_processor.py` will contain functions for processing natural language text for CNL development.

#### Testing
Unit tests are located in the `tests` directory, utilizing `pytest` to ensure the functionality of various components.

#### Flask API
`app.py` contains a simple Flask API for interacting with the STIX-D Corpus Database.

#### Table 1. List of Related Third-Party Repositories

| No. | Repository | Description |
|-----|------------|-------------|
| 1. | [APE](https://github.com/Attempto/APE) | ACE Parser Engine (APE) |
| 2. | [attack-stix-data](https://github.com/mitre-attack/attack-stix-data) | MITRE ATT&CK dataset represented in STIX 2.1 JSON collections. |
| 3. | [Clex](https://github.com/Attempto/Clex) | ACE Common Lexicon |
| 4. | [cti-pattern-validator](https://github.com/oasis-open/cti-pattern-validator) | A software tool for checking the syntax of the Cyber Threat Intelligence (CTI) STIX Pattern expressions |
| 5. | [cti-python-stix2](https://github.com/oasis-open/cti-python-stix2) | Python APIs for serializing and de-serializing STIX2 JSON content, along with higher-level APIs for common tasks, including data markings, versioning, and for resolving STIX IDs across multiple data sources. |
| 6. | [cti-stix2-json-schemas](https://github.com/oasis-open/cti-stix2-json-schemas) | JSON schemas and examples for STIX 2 |
| 7. | [cti-stix-validator](https://github.com/oasis-open/cti-stix-validator) | The STIX Validator checks that STIX JSON content conforms to the requirements specified in the STIX 2.1 specification. |
